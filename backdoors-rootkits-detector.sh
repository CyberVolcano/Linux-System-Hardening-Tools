 #!/bin/bash

apt install unhide -y
apt install chkrootkit -y
apt install rkhunter -y


rkhunter --update
rkhunter --propupd

echo 'APT_AUTOGEN="yes"' >> /etc/default/rkhunter

echo "-------------------" >> /CyberPatriot-Linux-Tools/results
echo "BACKDOOR DETECTED!" >> /CyberPatriot-Linux-Tools/results
echo "-------------------" >> /CyberPatriot-Linux-Tools/results

PotentialBackdoors=('netcat' 'netcat-openbsd' 'netcat-traditional' 'ncat' 'pnetcat' 'socat' 'sock' 'socket' 'sbd')

for program in "${PotentialBackdoors[@]}"; do
	dpkg -s $program &> /dev/null  
	if [ $? -ne 0 ]
	then
		echo $program "not installed"  
	else
		echo $program "DETECTED!" >> /CyberPatriot-Linux-Tools/results
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


#rkhunter --check --sk
#chkrootkit
#unhide -f brute proc procall procfs sys quick reverse