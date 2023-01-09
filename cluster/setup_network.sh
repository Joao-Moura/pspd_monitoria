#!/usr/bin

sudo systemctl stop NetworkManager
sudo ip addr flush $1
sudo ip address add $2/24 broadcast 192.168.133.255 dev $1
sudo ip route add default via 192.168.133.1

