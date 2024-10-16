#!/bin/bash
### Script to install mainline kernel manager ###
# Written by: chno
# Creation Date: Wed Oct 16 02:33:32 PM EDT 2024
# Last Update:Wed Oct 16 02:33:32 PM EDT 2024
# Last Update:N/A

echo "Adding repo..."
sudo add-apt-repository ppa:cappelikan/ppa -y

echo "Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing mainline..."
sudo apt install -y mainline

