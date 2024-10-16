#!/bin/bash
### Script to install mainline kernel manager ###
# Written by: chno
# Creation Date: Wed Oct 16 02:33:32 PM EDT 2024
# Last Update:Wed Oct 16 02:33:32 PM EDT 2024
# Last Update:N/A

echo "Adding repo..."
sudo apt-add-repository -y ppa:cappelikan/ppa

echo "Updating packages..."
sudo apt update

echo "Installing mainline..."
sudo apt install mainline

