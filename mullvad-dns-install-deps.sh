#! /usr/bin/env bash

installed() {
	command -v "$1" >> /dev/null
}

check_and_install_dependencies() {
	if installed dnf; then
		installer="dnf"
	fi

	if installed apt-get; then
		installer="apt-get"
	fi

	if ! installed nft; then
		echo "Installing dependency 'nft' (nftables)"
		sudo "$installer" install nftables
	fi

	if ! installed awk; then
		echo "Installing dependency 'awk' (gawk)"
		sudo "$installer" install gawk
	fi

	if ! installed inotifywait; then
		echo "Installing 'inotifywait' (inotify-tools)"
		sudo "$installer" install inotify-tools
	fi
	echo "All dependencies are installed."
}

check_and_install_dependencies
