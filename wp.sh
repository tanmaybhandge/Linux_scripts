#!/bin/bash


sudo yum install -y wget

mkdir -p /var/www/
pushd /var/www/
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
rm -f latest.tar.gz
chown -R apache:apache wordpress
mv html{,_old}
mv wordpress html
popd



# DB, Wordpress
INIT_ID="root"
INIT_PASSWORD="NzA1YjY0OT"
dbhost="10.38.78.57"
MYIP="10.38.78.52"

curl -s --data "dbname=wordpress&uname=$INIT_ID&pwd=$INIT_PASSWORD&dbhost=$dbhost&prefix=wp_&submit=Submit" \
http://$MYIP/wp-admin/setup-config.php?step=2

curl -s --data "weblog_title=CloudZ+Wordpress+QuickStart&user_name=$INIT_ID&admin_password=$INIT_PASSWORD& \
admin_password2=$INIT_PASSWORD&admin_email=admin%40example.com&blog_public=1&Submit=Install+WordPress" \
http://$MYIP/wp-admin/install.php?step=2
