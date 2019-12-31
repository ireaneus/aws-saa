#!/bin/bash
#
## Create Local Host Entry
echo "## My Custom Userdata ">> /etc/hosts
echo "$(ifconfig -a | grep inet | egrep -v "127.0.0.1|inet6" | awk '{print $2}')    mynewserver" >> /etc/hosts
#
## Create User
useradd david
echo testpass | passwd --stdin david
#
## Yum Update
yum update -y



#!/bin/bash
#
yum install httpd php php-mysql -y
yum update -y
chkconfig httpd on
service httpd start
echo "<?php phpinfo();?>" > /var/www/html/index.php
cd /var/www/html
wget https://s3.eu-west-2.amazonaws.com/acloudguru-example/connect.php


