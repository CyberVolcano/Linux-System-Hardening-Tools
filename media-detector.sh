#!/bin/bash

echo "-----------------------" >> /CyberPatriot-Linux-Tools/results
echo "UNAPPROVED MEDIA FILES!" >> /CyberPatriot-Linux-Tools/results
echo "-----------------------" >> /CyberPatriot-Linux-Tools/results

find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.mp3' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.mov' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.mp4' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.avi' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.mpg' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.flac' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.m4a' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.flv' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.ogg' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.gif' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.png' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.jpg' 2>> /CyberPatriot-Linux-Tools/results
find / -type d \( -path /run -o -path /lib -o -path /snap \) -prune -false -o -name '*.jpeg' 2>> /CyberPatriot-Linux-Tools/results
