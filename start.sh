#!/bin/bash
set -e

# Mount the SMB share
mount -t cifs //samwise.dsb.dk/app1 /mnt/smbshare -o guest

# Execute the CMD
exec "$@"