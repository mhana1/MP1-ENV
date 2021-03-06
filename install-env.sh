#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y  apache2 git php5 php5-curl mysql-client curl php5-mysql 
sudo apt-get install php5 php5-imagick
sudo service apache2 restart

git clone https://github.com/mhana1/MP1-APP.git

mv ./MP1-APP/images /var/www/html/images
mv ./MP1-APP/css /var/www/html/css
mv ./MP1-APP/*.html /var/www/html
mv ./MP1-APP/*.php /var/www/html

sudo rm index.html

curl -sS https://getcomposer.org/installer | sudo php &> /tmp/getcomposer.txt
sudo php composer.phar require aws/aws-sdk-php &> /tmp/runcomposer.txt
sudo mv vendor /var/www/html &> /tmp/movevendor.txt
#aws rds wait db-instance-available --db-instance-identifier 'mh-db'
sudo php /var/www/html/setup.php &> /tmp/database-setup.txt
chmod 600 /var/www/html/setup.php

echo "Hello!" > var/tmp/hello.txt
