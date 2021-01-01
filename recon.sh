#!/bin/bash

######## LIST POTENTIAL HACKING PROGRAMS #########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL HACKING PROGRAMS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

dpkg -l | grep -E '(crack|hack)'

dpkg -l | grep -E '(exploitation|injection)'

######## LIST PROGRAMS RELATING TO TORRENTING AND RDP #########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL TORRENTING AND RDP" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

dpkg -l | grep -E '(torrent|rdp)'

######## LIST REMOTE ACCESS PROGRAMS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL REMOTE ACCESS PROGRAMS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

dpkg -l | grep -E '(remote.+access)'

######## LIST RUNNING SERVICES ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "RUNNING SERVICES" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

service --status-all | grep '[+]'

######## FIND REVERSE SHELL PROGRAMS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL REVERSE SHELL PROGRAMS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

locate *reverse*shell*.*

######## FIND BACKDOOR SHELL PROGRAMS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL BACKDOOR SHELL PROGRAMS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

locate *backdoor*shell*.*

######## FIND PYTHON BACKDOORS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "POTENTIAL PYTHON BACKDOORS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

find / -xdev -type f -name "*.py" -exec grep -E -l "bind\(.+\)" {} \;

######## FIND PERL BACKDOORS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "PERL BACKDOORS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

find / -xdev -type f -name "*.pl" -exec grep -E -l "bind\(.+\)" {} \;

######## FIND COMMON PHP WEBSHELLS ###########

echo "-------------------------" >> /CyberPatriot-Linux-Tools/results
echo "COMMON PHP WEBSHELLS" >> /CyberPatriot-Linux-Tools/results
echo "-------------------------" >> /CyberPatriot-Linux-Tools/results

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php echo passthru\(\\$\_GET\['cmd']); \?>" {} \;

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php echo exec\(\\$\_POST\['cmd']); \?>" {} \;

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php system\(\\$\_GET\['cmd']); \?>" {} \;

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php passthru\(\\$\_REQUEST\['cmd']); \?>" {} \;
