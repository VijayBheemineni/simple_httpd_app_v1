#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl start httpd
systemctl enable httpd
systemctl status httpd

usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
cd /var/www/html
echo "Hello World Simple HTTPD" >> index.html