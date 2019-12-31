#!/bin/bash
#
## Create Local Host Entry
echo "## My Custom Userdata ">> /etc/hosts
echo "$(ifconfig -a | grep inet | egrep -v "127.0.0.1|inet6" | awk '{print $2}')    mynewserver" >> /etc/hosts
#
## Create User
useradd davidh
echo testpass | passwd --stdin davidh
