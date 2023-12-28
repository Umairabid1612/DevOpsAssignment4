#!/bin/bash
sudo apt update -y
sudo apt install -y mysql-server
sudo service mysql start
sudo systemctl enable mysql
sudo mysqladmin -u root password 'root123'
sudo mysql -u root -p'root123' -e "CREATE DATABASE wordpress;"
sudo mysql -u root -p'root123' -e "CREATE USER 'wp'@'%' IDENTIFIED BY 'wp123';"
sudo mysql -u root -p'root123' -e "GRANT ALL PRIVILEGES ON wordpress TO 'wp'@'%';"
sudo mysql -u root -p'root123' -e "FLUSH PRIVILEGES;"
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart

