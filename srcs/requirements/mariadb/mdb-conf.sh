#!/bin/bash

service mariadb start

sleep 5
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYDB_ROOT_PASSWORD';" > db1.sql > db1.sql
echo "CREATE DATABASE IF NOT EXISTS $MY_DB;" >> db1.sql
echo "CREATE USER IF NOT EXISTS '$MYDB_USER'@'%' IDENTIFIED BY '$MYDB_PASSWORD' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $MY_DB.* TO '$MYDB_USER'@'%' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mariadb -u root  -p$MYDB_ROOT_PASSWORD -e  "source db1.sql"


# pkill -9 mysqld

mysqladmin -u root -p$MYDB_ROOT_PASSWORD shutdown 
mysqld_safe
