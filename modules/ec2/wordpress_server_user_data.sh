#!/bin/bash

# Update packages
sudo apt-get update -y

# Install Apache and PHP for WordPress
sudo apt-get install -y apache2 php php-mysql

# Start Apache
sudo service apache2 start
sudo systemctl enable apache2

# Download and extract WordPress
cd /var/www/html
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo mv wordpress/* .
sudo rm -rf wordpress latest.tar.gz

# Set permissions
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Configure WordPress
sudo cp wp-config-sample.php wp-config.php

# Replace database configuration with actual values
sudo sed -i 's/database_name_here/wordpress/' wp-config.php
sudo sed -i 's/username_here/wp/' wp-config.php
sudo sed -i 's/password_here/wp123/' wp-config.php
sudo sed -i "s/localhost/${db_instance_ip}/" wp-config.php
