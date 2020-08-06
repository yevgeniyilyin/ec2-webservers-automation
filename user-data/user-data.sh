#!/bin/bash
sudo yum update -y
sudo yum install -y wget httpd php git

TAG_NAME="Picture"
INSTANCE_ID="`wget -qO- http://instance-data/latest/meta-data/instance-id`"
REGION="`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
TAG_VALUE="`aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=$TAG_NAME" --region $REGION --output=text | cut -f5`"

cd /var/www/html

rm pic.jpg
rm index.html

wget https://raw.githubusercontent.com/yevgeniyilyin/ec2-webservers-automation/master/images/$TAG_VALUE.jpg
wget https://raw.githubusercontent.com/yevgeniyilyin/ec2-webservers-automation/master/httpd/index.php
wget https://raw.githubusercontent.com/yevgeniyilyin/ec2-webservers-automation/master/httpd/htaccess
mv $TAG_VALUE.jpg pic.jpg
mv htaccess .htaccess

sudo systemctl start httpd
sudo systemctl enable httpd
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;