#!/bin/bash

apt install -y --reinstall mlocate

updatedb

######## LIST POTENTIAL HACKING PROGRAMS #########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL HACKING PROGRAMS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

dpkg -l | grep -E '(crack|hack)' >> /CyberPatriot-Linux-Tools/results

dpkg -l | grep -E '(exploitation|injection|sniffer|packet)' >> /CyberPatriot-Linux-Tools/results

######## LIST PROGRAMS RELATING TO TORRENTING AND RDP #########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL TORRENTING AND RDP" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

dpkg -l | grep -E '(torrent|rdp)' >> /CyberPatriot-Linux-Tools/results

######## LIST REMOTE ACCESS PROGRAMS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL REMOTE ACCESS PROGRAMS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

dpkg -l | grep -E '(remote.+access)' >> /CyberPatriot-Linux-Tools/results

######## LIST RUNNING SERVICES ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "RUNNING SERVICES" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

service --status-all | grep '[+]' >> /CyberPatriot-Linux-Tools/results

######## FIND REVERSE SHELL PROGRAMS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL REVERSE SHELL PROGRAMS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

locate *reverse*shell*.* >> /CyberPatriot-Linux-Tools/results

######## FIND BACKDOOR SHELL PROGRAMS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL BACKDOOR SHELL PROGRAMS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

locate *backdoor*shell*.* >> /CyberPatriot-Linux-Tools/results

######## FIND PYTHON BACKDOORS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL PYTHON BACKDOORS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

find / -xdev -type f -name "*.py" -exec grep -l -E '#!\/usr\/bin\/python' '{}' \; | xargs -d '\n' grep -l -E 'bind\(.+\)' >> /CyberPatriot-Linux-Tools/results

######## FIND PERL BACKDOORS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "PERL BACKDOORS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

find / -xdev -type f -name "*.pl" -exec grep -E -l "bind\(.+\)" {} \; >> /CyberPatriot-Linux-Tools/results

######## FIND COMMON PHP WEBSHELLS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "COMMON PHP WEBSHELLS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php echo passthru\(\\$\_GET\['cmd']); \?>" {} \; >> /CyberPatriot-Linux-Tools/results

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php echo exec\(\\$\_POST\['cmd']); \?>" {} \; >> /CyberPatriot-Linux-Tools/results

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php system\(\\$\_GET\['cmd']); \?>" {} \; >> /CyberPatriot-Linux-Tools/results

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php passthru\(\\$\_REQUEST\['cmd']); \?>" {} \; >> /CyberPatriot-Linux-Tools/results

######## FIND NETCAT ALIASES ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "FIND NETCAT ALIASES" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

sudo find / -xdev -type l -ls | grep "netcat"
sudo find / -xdev -type l -ls | grep "nc.openbsd"