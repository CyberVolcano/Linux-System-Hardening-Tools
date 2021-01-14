#!/bin/bash
input="/CyberPatriot-Linux-Tools/passwords"

while IFS= read -r var
do
	echo "Searching for: "$var
	find / -xdev -type f -exec grep -E -l "$var" {} \;
done < "$input"