
echo "-----------------" >> /CyberPatriot-Linux-Tools/results
echo "UNAPPROVED USERS!" >> /CyberPatriot-Linux-Tools/results
echo "-----------------" >> /CyberPatriot-Linux-Tools/results

cat /etc/passwd | grep "/bin/bash" |  cut -f1 -d":" > /CyberPatriot-Linux-Tools/list_of_users

input="/CyberPatriot-Linux-Tools/list_of_users"

while IFS= read -r var
do
  if [[ $(grep $var /CyberPatriot-Linux-Tools/approved_users) ]]; then
    :
 else
    echo $var " is an unapproved user!"
    echo $var " is an unapproved user!" >> /CyberPatriot-Linux-Tools/results
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

sudo useradd -D -f 35

#Disable inactive Accounts after 35 days

sudo systemctl mask ctrl-alt-del.target
sudo systemctl daemon-reload

#Configure the system to disable the Ctrl-Alt-Delete sequence for the command line with the following command:

touch /etc/modprobe.d/usb-storage.conf
echo "install usb-storage /bin/true" > /etc/modprobe.d/usb-storage.conf

#Disable Automatic USB Mounting

input="/CyberPatriot-Linux-Tools/approved_users"

while IFS= read -r var
do
  chown $var /home/$var


ls /home | xargs chgrp users  

ls /home | xargs chown 750