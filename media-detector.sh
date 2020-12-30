#!/bin/bash

echo "-----------------------" >> /CyberPatriot-Linux-Tools/PUPs
echo "UNAPPROVED MEDIA FILES!" >> /CyberPatriot-Linux-Tools/PUPs
echo "-----------------------" >> /CyberPatriot-Linux-Tools/PUPs

find / -xdev -iname '*.mp3' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.mov' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.mp4' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.avi' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.mpg' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.flac' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.m4a' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.flv' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.ogg' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.gif' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.png' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.jpg' >> /CyberPatriot-Linux-Tools/PUPs
find / -xdev -iname '*.jpeg' >> /CyberPatriot-Linux-Tools/PUPs

