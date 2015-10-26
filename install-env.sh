#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y  apache2 git php5 php5-curl mysql-client curl php5-mysql

git clone https://github.com/mhana1/MP1-APP.git

mv ./MP1-APP/images /var/www/html/images
mv ./MP1-APP/css /var/www/html/css
mv ./MP1-APP/*.html /var/www/html
mv ./MP1-APP/*.php /var/www/html

curl -sS https://getcomposer.org/installer | sudo php &> /tmp/getcomposer.txt

sudo php composer.phar require aws/aws-sdk-php &> /tmp/runcomposer.txt

sudo mv vendor /var/www/html &> /tmp/movevendor.txt

sudo php /var/www/html/setup.php &> /tmp/database-setup.txt

echo "Hello!" > var/tmp/hello.txt
