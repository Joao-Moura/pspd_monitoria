#!/usr/bin/bash

# Usage: bash setup_network.sh NETWORK_DEVICE IP_ADDRESS


NETWORK_DEVICE=$1
IP_ADDRESS=$2
BROADCAST_ADDRESS=${3:-192.168.133.255}
GATEWAY_ADDRESS=${4:-192.168.133.1}

sudo systemctl stop NetworkManager

sudo ip addr flush $NETWORK_DEVICE
sudo ip address add $IP_ADDRESS/24 broadcast $BROADCAST_ADDRESS dev $NETWORK_DEVICE
sudo ip route add default via $GATEWAY_ADDRESS

