#!/bin/bash

#Makes copies of old files
cp -f /etc/pam.d/common-password /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/pam.d/common-auth /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/security/pwquality.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/login.defs /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/sysctl.conf /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/rsyslog.d/50-default.conf /CyberPatriot-Linux-Tools/old_files/

cp -f /etc/issue /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/issue.net /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/motd /CyberPatriot-Linux-Tools/old_files/

cp -f /etc/audit/audit.rules /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/audit/auditd /CyberPatriot-Linux-Tools/old_files/

cp -f /etc/aide/aide.conf /CyberPatriot-Linux-Tools/old_files/

cp -f /etc/profile /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/bashrc /CyberPatriot-Linux-Tools/old_files/

cp -f /etc/hosts.allow /CyberPatriot-Linux-Tools/old_files/
cp -f /etc/hosts.deny /CyberPatriot-Linux-Tools/old_files/