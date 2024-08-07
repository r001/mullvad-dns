# mullvad-dns

Bash scripts to enable the [GUI version of Mullvad Vpn](https://mullvad.net/en/help/install-mullvad-app-linux/) to be used as a vpn layer in [Qubes Os](https://www.qubes-os.org/).

This version is tested with fedora-40 based mullvad-vm. (for fedora-38 based checkout v4.1.0 version by executing Installation step 0. and 1. then Troubleshoot -> Wrong Qubes version -> Resolution)


# Introduction

The advantage to use Mullvad GUI over installing wireguard scripts is its flexibility: you can easily change locations, enable and disable vpn using a nice GUI provided by [Mullvad](https:www.mullvad.net). The problem was until now, that dns just did not go through. Now it will. You will need `awk`, `nftables`, and `inotify-tools` available on your system. You will only need `mullvad-dns.sh` to be started along `Mullvad VPN` gui to make things work. The installation below makes sure that the script will start automatically each time mullvad starts, so things will work seamlessly.

# Prerequisities
We call your vm where mullvad gui is installed: **mullvad-vm** and its template vm: **mullvad-template-vm**.
Make sure that packages of `gawk`, `nftables`, and `inotify-tools` are installed in **mullvad-template-vm**. For the lazy the `mullvad-dns-install-deps.sh` will do this automatically for you on both Debian, and Fedora type systems. Make sure the packages above are available in **mullvad-vm** BEFORE you move on to actual installation. 
1. Install [GUI version of Mullvad Vpn](https://mullvad.net/en/help/install-mullvad-app-linux/).  
    1. Start Mullvad GUI, and in `Settings -> VPN Settings -> Tunel Protocol` set OpenVPN.  
    **This is IMPORTNT, otherwise Mllvad GUI will not work!!!!**
2. Clone this repo to your **mullvad-vm**.  
    `git clone https://github.com/r001/mullvad-dns.git`
3. Istall dependencies `gawk`, `nftables`, and `inotify-tools` in your **mullvad-template-vm**:  
   **a.** In your **mullvad-vm**:  
   `cd mullvad-dns && qvm-copy ./mullvad-dns-install-deps.sh`  
   hit **ENTER**, and chose **mullvad-template-vm** from the list to copy to.  

   **b.** In your **mullvad-template-vm**:  
   `cd /home/user/QubesIncoming/<mullvad-vm> && ./mullvad-dns-install-deps.sh`  

   **c.** Shutdown **mullvad-template-vm**.  

   **d.** Restart **mullvad-vm**.  

# Installation
0. Make sure `gawk`, `nftables`, and `inotify-tools` are installed. See [Prerequisities](#prerequisities) above.  
1. Clone this repo to your **mullvad-vm** to your HOME directory(if you haven't done so already in previous steps):  
    `cd`  
    `git clone https://github.com/r001/mullvad-dns.git`

2. Install the scripts in your **mullvad-vm**. This will start dns auto updates, and make dns changes automatic between restarts.  
    `cd`  
    `cd mullvad-dns`  
    `./mullvad-dns-install.sh`  

# Troubleshoot

## Missing dependencies
Run `/home/user/.mullvad-dns/mullvad-dns.sh`.  
If it complains about some command not having been installed.  
Resolution:  
Do one of the following:
- install missing commands. 
- or make sure the newly installed dependencies are actually visible in the **mullvad-vm** you need to:
  1. Shutdown **mullvad-template-vm** after installing dependencies, and 
  2. Restart **mullvad-vm** after **mullvad-template-vm** is shutdown.  

If it still complains about missing commands, then you need to install them manually in **mullvad-template-vm**.  

## Wrong Qubes version

Run `/home/user/.mullvad-dns/mullvad-dns.sh`.  
If it complains about wrong nftable, then your problem is probably using a Qubes version prior to 4.2. This script will not work on 4.1 and below, because of different netfilter tables are present in Qubes.  
Resolution:
- Please try previous version of this software for Qubes 4.1, and 4.0.
    1. In your **mullvad-vm**  
    `cd`  
    `cd mullvad-dns`  
    `git checkout v4.1.0`  
    `./mullvad-dns-install.sh`  

## VM behind **mullvad-vm** has no internet access

- Run `/home/user/.mullvad-dns/mullvad-dns.sh` in **mullvad-vm**.  
- Check if by turning Mullvad GUI off will result 'Mullvad is off' on command line.
- Program above does not display 'Mullvad is off'.

Resolution:
- Exit Mullvad GUI
- Start Mullvad GUI from command line:  
  `/opt/Mullvad\ VPN/mullvad-gui &`  
- Turn on VPN, and check if 'Mullvad is on' is displayed on command line.
- Now apps should have internet access.

# Usage

Should work automatically when you stop and start the mullvad vpn connection. No interaction is needed.
If you want to start the dns update manually, you can do it in your **mullvad-vm** by executing:  
  `/home/user/.mullvad-dns/mullvad-dns.sh &`  
  It will display when Mullvad is turned on or off.

# Notes

The scripts were tested under Qubes 4.2. and with fedora-40 as **mullvad-template-vm**.

# Uninstall

1. In your **mullvad-vm**:   
    `rm ~/.config/autostart/mullvad-dns.desktop`  
    `rm ~/.mullvad-dns/mullvad-dns.sh`
2. Restart **mullvad-vm**.

# License

[MIT](./LICENSE.txt)

# Credits

Robert Horvath (r001)
