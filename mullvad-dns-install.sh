#!/usr/bin/env bash

# make sure NO "/" at the end of the path
dest_dir="/home/user/.mullvad-dns"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# install dependencies to mullvad-vm so that it does not have to be restarted to operate
. "$SCRIPT_DIR"/mullvad-dns-install-deps.sh

echo "Creating directory $dest_dir"
mkdir -p "$dest_dir"
mkdir -p /home/user/.config/autostart

echo "Make sure scripts are executable"
chmod +x "$SCRIPT_DIR/mullvad-dns.sh"
chmod +x "$SCRIPT_DIR/mullvad-dns.desktop"

echo "Copying mullvad-dns.sh to $dest_dir"
cp "$SCRIPT_DIR/mullvad-dns.sh" "$dest_dir"

echo "Creating autostart entry in /home/user/.config/autostart/"
sed -i "s|Exec=.*|Exec=$dest_dir/mullvad-dns.sh|" "$SCRIPT_DIR/mullvad-dns.desktop"
cp "$SCRIPT_DIR/mullvad-dns.desktop" /home/user/.config/autostart/

echo "Starting mullvad-dns.sh"
$dest_dir/mullvad-dns.sh &
