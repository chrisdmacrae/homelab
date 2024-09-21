#!/bin/bash

# Check for correct number of arguments
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <REMOTE_IP> <SHARE_NAME> <MOUNT_POINT> <USERNAME> <PASSWORD>"
    exit 1
fi

# Copy to host and run script
cd "$(dirname "$0")"
scp ./setup-smb-mount.sh ${DOCKER_IP}:/tmp/setup_smb_mounts.sh
ssh ${DOCKER_IP} 'bash /tmp/setup_smb_mounts.sh' $1 $2 $3 $4 $5
