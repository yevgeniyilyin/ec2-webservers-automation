#!/bin/bash
sudo yum update -y
sudo yum install -y wget httpd php git

TAG_NAME="Cat"
INSTANCE_ID="`wget -qO- http://instance-data/latest/meta-data/instance-id`"
REGION="`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
TAG_VALUE="`aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=$TAG_NAME" --region $REGION --output=text | cut -f5`"

cd /var/www/html

sudo wget https://github.com/linuxacademy/content-aws-csa2019/raw/master/lesson_files/07_hybrid_scaling/1_LBandASG/CLBandHealth/$TAG_VALUE.jpg
sudo wget https://github.com/linuxacademy/content-aws-csa2019/raw/master/lesson_files/07_hybrid_scaling/1_LBandASG/CLBandHealth/index.php
sudo wget https://github.com/linuxacademy/content-aws-csa2019/raw/master/lesson_files/07_hybrid_scaling/1_LBandASG/CLBandHealth/htaccess
sudo mv $TAG_VALUE.jpg cat.jpg
sudo mv /var/www/html/htaccess /var/www/html/.htaccess

sudo mkdir /var/www/html/cat
sudo cp /var/www/html/cat.jpg /var/www/html/cat
sudo cp /var/www/html/index.php /var/www/html/cat
sudo cp /var/www/html/.htaccess /var/www/html/cat

sudo systemctl start httpd
sudo systemctl enable httpd
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
