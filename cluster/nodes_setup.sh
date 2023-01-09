#!/bin/bash

# Usage:

NODES_SSH=(lds1 lds2 lds3)

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
	ssh-keygen -t rsa
fi

for node in ${$NODES_SSH[@]}; do
	ssh-copy-id $node
done;
