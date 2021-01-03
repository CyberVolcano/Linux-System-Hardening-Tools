#!/bin/bash

read -p "What port is the backdoor using?: "  portNumber
echo "Searching for files using $portNumber as their port number!"
searchString=$(echo "bind\(.+""$portNumber""\)")

echo " "

find / -xdev -type f -exec grep -l -E "$searchString" {} \;