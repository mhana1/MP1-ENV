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

#create db instance if not exist
declare -a dbInsatnceARR

mapfile -t dbInstanceARR < <(aws rds describe-db-instances --output json | grep "\"DBInstanceIdentifier" | sed "s/[\"\:\, ]//g" | sed "s/DBInstanceIdentifier//g" )

if [ ${#dbInstanceARR[@]} -gt 0 ]
   then
   LENGTH=${#dbInstanceARR[@]}

       for (( i=0; i<${LENGTH}; i++));
      do
        if [ ${dbInstanceARR[i]} == "mh-db"]
        then
         echo "Database already exists"
        else
        echo "creating new database"
	sudo php /var/www/html/setup.php &> /tmp/database-setup.txt
        fi
   done
fi


echo "Hello!" > var/tmp/hello.txt
