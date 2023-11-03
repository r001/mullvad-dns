#! /usr/bin/env bash

update_dns() {
	# mullvad_on: 0 -> off, 1 -> on
	mullvad_on=$([[ $(grep -v -c "nameserver \+10.139" /etc/resolv.conf) -gt 0 ]] && echo 1 || echo 0)

	if [[ $mullvad_on -eq 1 ]]; then

		echo "Mullvad is on"

		# get the mullvad dns ip address. First one is used if there is more than one.
		mullvad_dns_ip=$(grep "nameserver" < /etc/resolv.conf| awk '{print $2}' | head -n 1)

		# collect all the handles of the lines in the forward chain that must be deleted
		nft_handles_to_delete=$(sudo nft -a list chain nat PR-QBS | grep "dport \+53" | awk '{print $NF}')

		# delete all the lines defined in previous step
		for handle in $nft_handles_to_delete; do
			sudo nft delete rule ip nat PR-QBS handle "$handle"
		done

		# forward all dns requests to mullvad dns servers
		sudo nft add rule nat PR-QBS ip daddr 10.139.1.1 udp dport 53 counter packets 0 dnat to "$mullvad_dns_ip"
		sudo nft add rule nat PR-QBS ip daddr 10.139.1.2 udp dport 53 counter packets 0 dnat to "$mullvad_dns_ip"

	else

		echo "Mullvad is off"

		# collect all the handles of the lines in the forward chain that must be deleted
		nft_handles_to_delete=$(sudo nft -a list chain nat PR-QBS | grep "dport \+53" | awk '{print $NF}')

		# delete all the lines defined in previous step
		for handle in $nft_handles_to_delete; do
			sudo nft delete rule ip nat PR-QBS handle "$handle"
		done

		# get qubes nameserver ip addresses
		nameserver_ips=$(grep "nameserver" < /etc/resolv.conf| awk '{print $2}')

		# add rule to forward dns requests to qubes nameservers
		for ip in $nameserver_ips; do
			sudo nft add rule nat PR-QBS ip daddr "$ip" udp dport 53 counter packets 0 dnat to "$ip"
		done

	fi
}

update_dns
# check for /etc/resolv.conf content change
inotifywait -m -q -e close_write /etc/resolv.conf | while read -r;
do
	update_dns
done
