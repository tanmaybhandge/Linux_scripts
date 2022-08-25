#!/bin/bash

# Yum
yum update -y
yum install -y httpd php php-mysqlnd expect wget

chown -R apache:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

systemctl start httpd
systemctl enable httpd


# Wordpress
mkdir -p /var/www/
pushd /var/www/
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
rm -f latest.tar.gz
chown -R apache:apache wordpress
mv html{,_old}
mv wordpress html
popd
