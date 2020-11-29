#!/bin/bash

#PUT CLEARTEXT PASSWORD HERE
password=secret-p@ssword

grep -rnw /bin -e $password
grep -rnw /cdrom -e $password
grep -rnw /home -e $password
grep -rnw /boot -e $password
grep -rnw /lib -e $password
grep -rnw /lib64 -e $password
grep -rnw /lost+found -e $password
grep -rnw /mnt -e $password
grep -rnw /opt -e $password
grep -rnw /opt -e $password
grep -rnw /root -e $password
grep -rnw /sbin -e $password
grep -rnw /sbin -e $password
grep -rnw /usr -e $password
grep -rnw /var -e $password
grep -rnw /tmp -e $password
grep -rnw /etc -e $password