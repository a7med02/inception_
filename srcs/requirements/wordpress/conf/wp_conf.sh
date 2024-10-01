#!/bin/bash


curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

mkdir -p /var/www/html
cd /var/www/html

wp core download --allow-root --force
echo "download wordpress"
mv wp-config-sample.php wp-config.php
chown www-data:www-data  -R *
mkdir /run/php
echo "wordpress downloaded"

wp config set DB_NAME $MY_DB --allow-root --path=/var/www/html
wp config set WP_CACHE_KEY_SALT wordpress  --allow-root --path=/var/www/html
wp config set WP_CACHE true  --allow-root --path=/var/www/html

wp config set DB_USER $MYDB_USER --allow-root --path=/var/www/html
wp config set DB_PASSWORD $MYDB_PASSWORD --allow-root --path=/var/www/html
wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html

echo "DB_NAME: $MY_DB"
echo "DB_USER: $MYDB_USER"
echo "DB_PASSWORD: $MYDB_PASSWORD"

wp core install --url=$DOMAIN_NAME --title=INCEPTION --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_P --admin_email=$WP_ADMIN_E --allow-root --path=/var/www/html
wp theme install bizboost --allow-root --path=/var/www/html
wp theme activate bizboost --allow-root --path=/var/www/html
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# mkdir -p /var/www/html
# cd /var/www/html

# echo "download wordpress"
# wp core download --allow-root
# mv wp-config-sample.php wp-config.php
# chown www-data:www-data  -R *
# mkdir /run/php
# echo "wordpress downloaded"

# wp config set DB_NAME $MY_DB --allow-root --path=/var/www/html

# wp config set WP_CACHE_KEY_SALT wordpress  --allow-root --path=/var/www/html
# wp config set WP_CACHE true  --allow-root --path=/var/www/html


# wp config set DB_USER $MYDB_USER --allow-root --path=/var/www/html
# wp config set DB_PASSWORD $MYDB_PASSWORD --allow-root --path=/var/www/html
# wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html

# wp core install --url=$DOMAIN_NAME --title=INCEPTION --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_P --admin_email=$WP_ADMIN_E --allow-root --path=/var/www/html
# wp theme install bizboost --allow-root --path=/var/www/html
# wp theme activate bizboost --allow-root --path=/var/www/html

# wp user create $WP_USER $WP_USER_E --role=author --user_pass=$WP_USER_PASS --allow- --path=/var/www/html

# sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/7.4/fpm/pool.d/www.conf
# sed -i 's/;extension=mysqli/extension=mysqli/' /etc/php/7.4/fpm/php.ini
# sed -i 's/;   extension=mysqli/extension=mysqli/' /etc/php/7.4/cli/php.ini

# /usr/sbin/php-fpm7.4 -F