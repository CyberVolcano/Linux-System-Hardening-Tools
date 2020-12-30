#!/bin/bash

#Makes copies of old files
cp -f /etc/pam.d/common-password /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/pam.d/common-auth /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/security/pwquality.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/login.defs /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/sysctl.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/rsyslog.d/50-default.conf /CyberPatriot-Linux-Tools/old_files/

cp -f /etc/sudoers /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/passwd /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/group /CyberPatriot-Linux-Tools/old_files/

cp -f /etc/securetty /CyberPatriot-Linux-Tools/old_files/

if [ -f "/etc/issue" ]; then
   cp -f /etc/issue /CyberPatriot-Linux-Tools/old_files/
fi

if [ -f "/etc/issue.net" ]; then
   cp -f /etc/issue.net /CyberPatriot-Linux-Tools/old_files/
fi

if [ -f "/etc/motd" ]; then
   cp -f /etc/motd /CyberPatriot-Linux-Tools/old_files/
fi

cp -f /etc/audit/audit.rules /CyberPatriot-Linux-Tools/old_files/

cp -f /etc/profile /CyberPatriot-Linux-Tools/old_files/

if [ -f "/etc/bashrc" ]; then
   cp -f /etc/bashrc /CyberPatriot-Linux-Tools/old_files/
fi

if [ -f "/etc/hosts.allow" ]; then
   cp -f /etc/hosts.allow /CyberPatriot-Linux-Tools/old_files/
fi

if [ -f "/etc/hosts.deny" ]; then
   cp -f /etc/hosts.deny /CyberPatriot-Linux-Tools/old_files/
fi
cp -f /etc/host.conf /CyberPatriot-Linux-Tools/old_files/

cp -f /etc/rc.local /CyberPatriot-Linux-Tools/old_files/