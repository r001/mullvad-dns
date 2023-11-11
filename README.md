# mullvad-dns

Bash scripts to enable the [GUI version of Mullvad Vpn](https://mullvad.net/en/help/install-mullvad-app-linux/) to be used as a vpn layer in [Qubes Os](https://www.qubes-os.org/).

# Introduction

The advantage to use Mullvad GUI over installing wireguard scripts is its flexibility: you can easily change locations, enable and disable vpn using a nice GUI provided by [Mullvad](https:www.mullvad.net). The problem was until now, that dns just did not go through. Now it will. You will need `awk`, `nftables`, and `inotify-tools` available on your system. You will only need `mullvad-dns.sh` to be started along `Mullvad VPN` gui to make things work. The installation below makes sure that the script will start automatically each time mullvad starts, so things will work seamlessly.

# Prerequisities
We call your vm where mullvad gui is installed: **mullvad-vm** and its template vm: **mullvad-template-vm**.
Make sure that packages of `gawk`, `nftables`, and `inotify-tools` are installed in **mullvad-template-vm**. For the lazy the `mullvad-dns-install-deps.sh` will do this automatically for you on both Debian, and Fedora type systems. Make sure the packages above are available in **mullvad-vm** BEFORE you move on to actual installation. 
1. Clone this repo to your **mullvad-vm**.  
    `git clone https://github.com/r001/mullvad-dns.git`
2. Istall dependencies `gawk`, `nftables`, and `inotify-tools` in your **mullvad-template-vm**:  
   **a.** In your **mullvad-vm**:  
   `cd mullvad-dns && qvm-copy ./mullvad-dns-install-deps.sh`  
   hit **ENTER**, and chose **mullvad-template-vm** from the list to copy to.  

   **b.** In your **mullvad-template-vm**:  
   `cd /home/user/QubesIncoming/<mullvad-vm> && ./mullvad-dns-install-deps.sh`  

   **c.** Shutdown **mullvad-template-vm**.  

   **d.** Restart **mullvad-vm**.  

# Installation
0. Make sure `gawk`, `nftables`, and `inotify-tools` are installed. See [Prerequisities](#prerequisities) above.  
1. Clone this repo to your **mullvad-vm** (if you haven't done so already in previous steps):  
    `git clone https://github.com/r001/mullvad-dns.git`

2. Install the scripts in your **mullvad-vm**. This will start dns auto updates, and make dns changes automatic between restarts.  
    `cd mullvad-dns`  
    `./mullvad-dns-install.sh`  

# Troubleshoot

To make sure the newly installed dependencies are actually visible in the **mullvad-vm** you need to:
1. Shutdown **mullvad-template-vm** after installing dependencies, and 
2. Restart **mullvad-vm** after **mullvad-template-vm** is shutdown.

# Usage

Should work automatically when you stop and start the mullvad vpn connection. No interaction is needed.
If you want to start the dns update manually, you can do it in your **mullvad-vm** by executing:  
  `/home/user/.mullvad-dns/mullvad-dns.sh &`  
  It will display when Mullvad is turned on or off.

# Notes

The scripts were tested under Qubes 4.1. and with fedora-38 as **mullvad-template-vm**.

# Uninstall

1. In your **mullvad-vm**:   
    `rm ~/.config/autostart/mullvad-dns.desktop`  
    `rm ~/.mullvad-dns/mullvad-dns.sh`
2. Restart **mullvad-vm**.

# License

[MIT](./LICENSE.txt)

# Credits

Robert Horvath (r001)
