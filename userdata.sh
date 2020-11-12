#!/bin/bash
yum install -y epel-release
yum install -y nginx
echo "HELLO WELCOME TO DEVOPS DEMO" > /usr/share/nginx/html/index.html
systemctl start nginx
