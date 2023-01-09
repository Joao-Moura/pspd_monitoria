#!/bin/usr/bash

# Usage: bash setup_worker.sh NFS_MASTER_HOST NFS_DIR

NFS_MASTER_HOST=${1:-lds1}
NFS_DIR=${2:-/mnt/pspd-lds}
MOUNT_DIR=${3:-/mnt/pspd-lds/}

sudo mount $NFS_MASTER_HOST:$NFS_DIR $NFS_DIR

sudo systemctl start sshd

