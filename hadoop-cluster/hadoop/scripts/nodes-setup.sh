#!/bin/bash

# nodes=("cm1" "cm2" "cm3" "cm4" "gpu1" "gpu2" "gpu3")
nodes_ssh=("hadoop1@hadoop1" "hadoop2@hadoop2")

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
    ssh-keygen -t rsa
fi

for node in ${nodes_ssh[@]}; do
    ssh-copy-id $node
done;
