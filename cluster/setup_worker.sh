#!/bin/usr/bash

sudo mount $1:$2 $2
sudo systemctl start sshd

