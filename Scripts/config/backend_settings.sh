#!/bin/bash

# This script will be used to store the backend settings needed for optimization of the operating system.

# The script must ensure it is run with root or sudo privileges for system-wide changes.
if [ "$(id -u)" -ne 0 ]; then
    echo "This script needs to be run as root or with sudo privileges."
    exit 1
fi


# Set the timezone to America/New_York.
sudo timedatectl set-timezone America/New_York

# Create the configuration file to disable Wi-Fi power saving.
cat << EOF > /etc/NetworkManager/conf.d/wifi-powersave.conf
[connection]
wifi.powersave = 2
EOF

echo "Wi-Fi power saving has been disabled."

# Restart network manager.
systemctl restart NetworkManager
echo "Network Manager restarted."