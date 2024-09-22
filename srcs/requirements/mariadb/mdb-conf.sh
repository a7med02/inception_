#!/bin/bash

service mariadb start 
sleep 5 

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MY_DB}\`;"

mariadb -e "CREATE USER IF NOT EXISTS \`${MYDB_USER}\`@'%' IDENTIFIED BY '${MYDB_PASSWORD}';"

mariadb -e "GRANT ALL PRIVILEGES ON ${MY_DB}.* TO \`${MYDB_USER}\`@'%';"

mariadb -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$MYDB_ROOT_PASSWORD shutdown

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
