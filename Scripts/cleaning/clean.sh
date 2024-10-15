#!/bin/bash

# AUTHOR:  @Limbicnation on github
# ADDED BY: chno
# DATE: Tue Oct 15 12:56:21 PM EDT 2024
# DESCRIPTION: Automates cleaning tasks on Ubuntu to free up disk space. It clears caches, removes unused packages, cleans logs, and deletes old files, helping maintain system efficiency. 

# Exit on error
set -e

# Script to clean up Ubuntu system

echo "Starting cleanup process..."

# Update package list
echo "Updating package list..."
if sudo apt-get update; then
    echo "Package list updated successfully."
else
    echo "Failed to update package list."
fi

# Clear user cache
echo "Clearing user cache..."
if rm -rf ~/.cache/*; then
    echo "User cache cleared."
else
    echo "Failed to clear user cache."
fi

# Clean up the APT cache
echo "Cleaning up APT cache..."
if sudo apt-get clean; then
    echo "APT cache cleaned."
else
    echo "Failed to clean APT cache."
fi

# Remove obsolete packages
echo "Removing obsolete packages..."
if sudo apt-get autoclean; then
    echo "Obsolete packages removed."
else
    echo "Failed to remove obsolete packages."
fi

# Remove unused packages and dependencies
echo "Removing unused packages and dependencies..."
if sudo apt-get autoremove; then
    echo "Unused packages and dependencies removed."
else
    echo "Failed to remove unused packages and dependencies."
fi

# Remove old kernel versions
echo "Removing old kernel versions..."
if sudo apt-get autoremove --purge; then
    echo "Old kernel versions removed."
else
    echo "Failed to remove old kernel versions."
fi

# Install bleachbit and clean system caches and temporary files
echo "Installing BleachBit and cleaning system caches..."
if sudo apt-get install -y bleachbit; then
    sudo bleachbit --clean system.cache system.localizations system.tmp
    echo "System caches cleaned using BleachBit."
else
    echo "Failed to install BleachBit."
fi

# Remove unused Snap packages
echo "Removing unused Snap packages..."
sudo snap list --all | awk '/disabled/{print $1, $3}' | while read snapname revision; do
    sudo snap remove "$snapname" --revision="$revision"
done
echo "Unused Snap packages removed."

# Clear thumbnail cache
echo "Clearing thumbnail cache..."
if rm -rf ~/.cache/thumbnails/*; then
    echo "Thumbnail cache cleared."
else
    echo "Failed to clear thumbnail cache."
fi

# Clean up systemd journal logs
echo "Cleaning up systemd journal logs to limit time to 10 days..."
if sudo journalctl --vacuum-time=10d; then
    echo "Systemd journal logs cleaned."
else
    echo "Failed to clean systemd journal logs."
fi

# Remove items from user Trash
echo "Removing items from user Trash..."
if rm -rf ~/.local/share/Trash/*; then
    echo "User Trash cleared."
else
    echo "Failed to clear user Trash."
fi

# Remove old log files
echo "Cleaning up old log files..."
if sudo journalctl --vacuum-size=50M; then
    echo "Old log files cleaned."
else
    echo "Failed to clean old log files."
fi

# Additional clean up of APT cache
echo "Cleaning up APT cache again..."
if sudo apt-get clean && sudo apt-get autoclean; then
    echo "APT cache cleaned again."
else
    echo "Failed to clean APT cache again."
fi

# Display APT cache size
echo "Displaying APT cache size..."
sudo du -sh /var/cache/apt

# Remove old files from /tmp directory
echo "Removing old files from /tmp directory..."
if sudo find /tmp -type f -atime +10 -delete; then
    echo "Old files from /tmp directory removed."
else
    echo "Failed to remove old files from /tmp directory."
fi

# Remove old log files from /var/log
echo "Removing old log files from /var/log..."
if sudo find /var/log -type f -name "*.log" -mtime +7 -exec rm {} \;; then
    echo "Old log files from /var/log removed."
else
    echo "Failed to remove old log files from /var/log."
fi

# Clean up core dump files
echo "Cleaning up core dump files from /var/lib/apport/coredump..."
if sudo find /var/lib/apport/coredump -type f -name 'core*' -delete; then
    echo "Core dump files cleaned."
else
    echo "Failed to clean core dump files."
fi

# Remove orphaned packages (requires deborphan)
if command -v deborphan &> /dev/null; then
    echo "Removing orphaned packages..."
    if sudo deborphan | xargs sudo apt-get -y remove --purge; then
        echo "Orphaned packages removed."
    else
        echo "Failed to remove orphaned packages."
    fi
else
    echo "deborphan not installed, skipping removal of orphaned packages."
fi

echo "Cleanup process completed."

