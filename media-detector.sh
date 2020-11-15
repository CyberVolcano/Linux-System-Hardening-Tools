#!/bin/bash

echo "-----------------------" >> /CyberPatriot-Linux-Tools/PUPs
echo "UNAPPROVED MEDIA FILES!" >> /CyberPatriot-Linux-Tools/PUPs
echo "-----------------------" >> /CyberPatriot-Linux-Tools/PUPs

find / -iname '*.mp3' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.mov' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.mp4' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.avi' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.mpg' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.flac' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.m4a' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.flv' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.ogg' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.gif' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.png' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.jpg' >> /CyberPatriot-Linux-Tools/PUPs
find / -iname '*.jpeg' >> /CyberPatriot-Linux-Tools/PUPs