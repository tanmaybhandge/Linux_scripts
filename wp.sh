#!/bin/bash

# DB, Wordpress 초기비번 정의 /root/INIT_PASSWORD
INIT_ID="root"
INIT_PASSWORD="ODFiOTBhOG"
dbhost="10.38.78.56"
MYIP="10.38.78.51"

curl -s --data "dbname=wordpress&uname=$INIT_ID&pwd=$INIT_PASSWORD&dbhost=$dbhost&prefix=wp_&submit=Submit" \
http://$MYIP/wp-admin/setup-config.php?step=2
curl -s --data "weblog_title=CloudZ+Wordpress+QuickStart&user_name=$INIT_ID&admin_password=$INIT_PASSWORD& \
admin_password2=$INIT_PASSWORD&admin_email=admin%40example.com&blog_public=1&Submit=Install+WordPress" \
http://$MYIP/wp-admin/install.php?step=2