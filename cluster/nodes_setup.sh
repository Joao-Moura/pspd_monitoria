#!/bin/bash

BASEDIR=/mnt/pspd-lds/share
NODES=($(cat $BASEDIR/nodes))

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
	ssh-keygen -t rsa
fi

for node in ${NODES[@]}; do
	ssh-copy-id $node
done;
