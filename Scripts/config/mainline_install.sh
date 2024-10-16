#!/bin/bash
### Script to install mainline kernel manager ###
# Written by: chno
# Creation Date: Wed Oct 16 02:33:32 PM EDT 2024
# Last Update:Wed Oct 16 02:46:59 PM EDT 2024
# Last Update:Added the install of software-properties-common as this is where the add-apt-repository command comes from and it was not installed.

echo "Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing software properties..."
sudo apt install software-properties-common

echo "Adding repo..."
sudo add-apt-repository ppa:cappelikan/ppa -y

echo "Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing mainline..."
sudo apt install -y mainline

