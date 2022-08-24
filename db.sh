#!/bin/bash

# DB, Wordpress 초기비번 정의 /root/INIT_PASSWORD
INIT_ID="root"
INIT_PASSWORD=$(date +%s | sha256sum | base64 | head -c 10)
echo $INIT_PASSWORD > /root/INIT_PASSWORD

# DB 비번 초기화 ============================
/usr/bin/mysqladmin -u root password "$INIT_PASSWORD"
SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$INIT_PASSWORD\r\"
expect \"Change the root password?\"
send \"y\r\"
expect \"New password\"
send \"$INIT_PASSWORD\r\"
expect \"Re-enter new password\"
send \"$INIT_PASSWORD\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")
echo "$SECURE_MYSQL"

# Mysql 설정 : wordpress DB 생성, User/PW 생성
mysql -u root -p$INIT_PASSWORD mysql -e "\
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON *.* TO '$INIT_ID'@'localhost' IDENTIFIED BY '$INIT_PASSWORD' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO '$INIT_ID'@'%'  IDENTIFIED BY '$INIT_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;\
"
