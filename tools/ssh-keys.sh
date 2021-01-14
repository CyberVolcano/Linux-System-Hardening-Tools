#!/bin/bash

for USER in $(cat /home/ubuntu/Desktop/users)
do
	mkdir -p /home/$USER/.ssh/
	#ssh-keygen -b 2048 -t rsa -f /home/$USER/.ssh/id_rsa -q -N "CyberP@triot!1"
	ssh-keygen -b 4096 -t ed25519 -f /home/$USER/.ssh/id_rsa -q -N "CyberP@triot1"
done