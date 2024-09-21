#!/bin/bash

# Variables from arguments
REMOTE_IP="$1"
SHARE_NAME="$2"
MOUNT_POINT="$3"
USERNAME="$4"
PASSWORD="$5"
SECURITY="user"                   # Security mode (default is 'user')
OPTIONS="file_mode=0777,dir_mode=0777,vers=3.0"  # SMB options

# Install cifs-utils if not installed
if ! dpkg -l | grep -qw cifs-utils; then
    echo "cifs-utils is not installed. Installing..."
    sudo apt update
    sudo apt install -y cifs-utils
fi

# Create mount point
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point at $MOUNT_POINT..."
    sudo mkdir -p "$MOUNT_POINT"
fi

# Create a credentials file
CREDENTIALS_FILE="/etc/smbcredentials"
echo "Creating credentials file at $CREDENTIALS_FILE..."
{
    echo "username=$USERNAME"
    echo "password=$PASSWORD"
} | sudo tee $CREDENTIALS_FILE > /dev/null
sudo chmod 600 $CREDENTIALS_FILE

# Add the mount to fstab
FSTAB_ENTRY="//${REMOTE_IP}/${SHARE_NAME} ${MOUNT_POINT} cifs credentials=${CREDENTIALS_FILE},${OPTIONS},iocharset=utf8 0 0"

# Check if the entry already exists in /etc/fstab
if ! grep -qs "$(echo "$FSTAB_ENTRY" | sed 's/\//\\\//g')" /etc/fstab; then
    echo "Adding entry to /etc/fstab..."
    # Use echo with sudo tee to append the entry
    echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab > /dev/null
fi


# Mount the share
echo "Mounting the SMB share..."
sudo mount -a

echo "SMB share mounted successfully at $MOUNT_POINT."
