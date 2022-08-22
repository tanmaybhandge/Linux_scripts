#!/bin/bash
# package updates

#sudo yum check-update
#sudo yum update


# apache installation, enabling and status check

sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd

sudo systemctl status httpd | grep Active

# firewall installation, start and status check

sudo yum install firewalld
sudo systemctl start firewalld
sudo systemctl status firewalld | grep Active

# adding http and https services
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https

# reloading the firewall
sudo firewall-cmd --reload

# acquiring the ip address for access to the web server
echo "this is the public IP address:" `curl -4 icanhazip.com`

# adding the needed permissions for creating and editing the index.html file
sudo chown -R $USER:$USER /var/www

# creating the html landing page
cd /var/www/html/
echo '<!DOCTYPE html>' > index.html
echo '<html>' >> index.html
echo '<head>' >> index.html
echo '<title>Demo Title</title>' >> index.html
echo '</head>' >> index.html
echo '<body>' >> index.html
echo '<h1>Hello World, This is Demo Page deployed from script</h1>' >> index.html
echo '</body>' >> index.html
echo '</html>' >> index.html
