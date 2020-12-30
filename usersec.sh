#!/bin/bash

echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "UNAPPROVED USERS!" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

cat /etc/passwd | grep "/home" |  cut -f1 -d":" > /CyberPatriot-Linux-Tools/list_of_users

read -p "What is the name of the admin user: "  userExclude
echo "Excluding: $userExclude"

input="/CyberPatriot-Linux-Tools/list_of_users"

while IFS= read -r var
do
  if [ $(grep $var /CyberPatriot-Linux-Tools/approved_users) ]; then
    chgrp users /home/$var
    chown 750 /home/$var

	if [ "$var" == "$userExclude" ]; then
		echo "This is the competition user!"
	else
		chage -m 10 -M 90 -W 7 $var
	fi

    #UNLOCK USER ACCOUNTS & SET THEIR SHELL TO BASH
    usermod -s /bin/bash $var
    passwd -u $var
 
    echo $var " is an unapproved user!"
    echo $var " is an unapproved user!" >> /CyberPatriot-Linux-Tools/results
 fi

done < "$input"

input=/etc/passwd

while IFS= read -r var
do
	userID=$(echo $var | cut -d: -f1 | xargs id -u)
	accountName=$(echo $var | cut -d: -f1)
	if [ $userID -eq 0 ]; then
		echo "That is a root account"
	elif [ $userID -lt 1000 ]; then
		echo "Locking system account"
		echo $var | cut -d: -f1 | xargs usermod -s /usr/sbin/nologin
	else
		echo "This must be a user account"
	fi

done < "$input"

sudo egrep -i '(nopasswd|!authenticate)' /etc/sudoers /etc/sudoers.d/*

echo "-------------------" >> /CyberPatriot-Linux-Tools/results
echo "USERS WITH 0 AS ID !" >> /CyberPatriot-Linux-Tools/results
echo "-------------------" >> /CyberPatriot-Linux-Tools/results

awk -F: '($3 == "0") {print}' /etc/passwd >> /CyberPatriot-Linux-Tools/results

echo "-------------------" >> /CyberPatriot-Linux-Tools/results
echo "USERS WITH NO PASSWORD" >> /CyberPatriot-Linux-Tools/results
echo "-------------------" >> /CyberPatriot-Linux-Tools/results

awk -F: '($2 == "") {print}' /etc/shadow

awk -F ":" 'list[$3]++{print $1, $3}' /etc/passwd

#Disable inactive Accounts after 30 days

sudo useradd -D -f 30

input="/CyberPatriot-Linux-Tools/approved_users"

while IFS= read -r var
do
  chown $var /home/$var

done < "$input"

groupdel lp
groupdel news
groupdel mail
groupdel uucp
groupdel games
