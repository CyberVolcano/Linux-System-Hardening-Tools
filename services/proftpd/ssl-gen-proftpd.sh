#!/bin/bash
echo -e "\nPlease enter a name for your SSL Certificate and Key pairs:"
read name
 openssl req -x509 -newkey rsa:1024 \
          -keyout /etc/ssl/private/$name.key -out /etc/ssl/certs/$name.crt \
          -nodes -days 365\

chmod 0600 /etc/ssl/private/$name.key