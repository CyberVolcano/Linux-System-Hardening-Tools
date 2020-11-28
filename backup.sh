#!/bin/bash

#Makes copies of old files
cp -f /etc/pam.d/common-password /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/pam.d/common-auth /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/security/pwquality.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/login.defs /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/sysctl.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/syslog.d/50-default.conf /CyberPatriot-Linux-Tools/old_files/