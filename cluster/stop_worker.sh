#!/bin/bash

NFS_MOUNT_DIR=${1:-/mnt/pspd-lds}

sudo systemctl stop sshd
sudo systemctl restart NetworkManager
sudo umount $NFS_MOUNT_DIR

