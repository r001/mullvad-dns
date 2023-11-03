# mullvad-dns
Bash scripts to use Mullvad Vpn GUI as a vpn layer in Qubes os.

# Installation
1. We call your vm where mullvad gui is installed: **mullvad-vm** and its template vm: **mullvad-template-vm**.
2. Clone this repo to your **mullvad-vm**.  
    `git clone https://github.com/r001/mullvad-dns.git`
3. Install dependencies (**gawk**, **nftables**, **inotify-tools**) to the **mullvad-template-vm** either by yourself or by following the steps below **3./a - 3./d** by copying the **mullvad-dns-install-deps.sh** to the **mullvad-template-vm** and execute it there.  

   **a.** In your **mullvad-vm**: `cd mullvad-dns && qvm-copy ./mullvad-dns-install-deps.sh` hit `<ENTER>`, and chose **mullvad-template-vm** from the list to copy to.  

   **b.** In your **mullvad-template-vm**: `cd /home/user/QubesIncoming/<mullvad-vm> && ./mullvad-dns-install-deps.sh`  
   **c.** Shutdown **mullvad-template-vm**.  

   **d.** Restart **mullvad-vm**.  
4. Install the scripts in your **mullvad-vm**. This will start dns auto updates, and make dns changes automatic between restarts.  
    `cd mullvad-dns`  
    `./mullvad-dns-install.sh`

# Usage
Should work automatically when you stop and start the mullvad vpn connection. No interaction is needed.

# Uninstall
1. In your **mullvad-vm**:   
    `rm ~/.config/autostart/mullvad-dns.desktop`  
    `rm ~/.mullvad-dns/mullvad-dns.sh`
2. Restart **mullvad-vm**.

# License
MIT

# Credits
Robert Horvath