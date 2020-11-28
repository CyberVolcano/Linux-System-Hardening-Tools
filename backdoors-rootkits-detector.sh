 #!/bin/bash

sudo apt install rkhunter -y
sudo rkhunter --propupd
rkhunter --update
echo 'APT_AUTOGEN="yes"' >> /etc/default/rkhunter

PotentialBackdoors=('netcat' 'netcat-openbsd' 'netcat-traditional' 'ncat' 'pnetcat' 'socat' 'sock' 'socket' 'sbd')

for program in "${PotentialBackdoors[@]}"; do
	dpkg -s $program &> /dev/null  
	if [ $? -ne 0 ]
	then
		echo "not installed"  
	else
		echo $program "DETECTED!"
	fi
done

OS_VERSION=$(lsb_release -d)

if [[ $OS_VERSION == *"Ubuntu 16"* ]]; then
	echo "UBUNTU 16 DETECTED"
	/bin/lsmod | awk '{print $1}' > /CyberPatriot-Linux-Tools/TargetSystemKernelModules

elif [[ $OS_VERSION == *"Ubuntu 18"* ]]; then
	echo "UBUNTU 18 DETECTED"
	/bin/lsmod | awk '{print $1}' > /CyberPatriot-Linux-Tools/TargetSystemKernelModules
fi

echo ""