#!/bin/bash

echo "=> Starting WordPress entrypoint script"

echo "=> Setting up WordPress directory"
if [ ! -d /var/www/wordpress ]; then
	mkdir -p /var/www/wordpress
fi

echo "=> Setting up PHP directory"
if [ ! -d /run/php ]; then
	mkdir -p /run/php
	chmod 777 /run/php
fi

echo "=> Installing wp-cli"
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
echo "=> Moving wp-cli.phar to /usr/local/bin/wp"
mv wp-cli.phar /usr/local/bin/wp
echo "=> Done!"

echo "=> Waiting for MariaDB to start"
until mysqladmin --user=${DB_USER} --password=${DB_USER_PASSWORD} --host=mariadb ping; do
	sleep 2
done

echo "=> Checking if WordPress is already installed"
if [ ! -f /var/www/wordpress/wp-config.php ]; then

	chown -R www-data:www-data /var/www/wordpress
	rm -rf /var/www/wordpress/*
	echo "=> Installing WordPress"
	wp core download --allow-root --version=6.5 --path='/var/www/wordpress'

	cd /var/www/wordpress

	echo "=> Configuring WordPress"
	mv wp-config-sample.php wp-config.php
	sed -i "s/database_name_here/${DB_NAME}/g" wp-config.php
	sed -i "s/username_here/${DB_USER}/g" wp-config.php
	sed -i "s/password_here/${DB_USER_PASSWORD}/g" wp-config.php
	sed -i "s/localhost/${DB_HOST}/g" wp-config.php
	#wp config create	--allow-root \
	#					--dbname=$DB_NAME \
	#					--dbuser=$DB_USER \
	#					--dbpass=$DB_USER_PASSWORD \
	#					--dbhost=$DB_HOST \
	#					--path='/var/www/wordpress'

	wp core install		--url=${WP_URL} \
						--title=${WP_TITLE} \
						--admin_user=${WP_ADMIN_USER} \
						--admin_password=${WP_ADMIN_PASSWORD} \
						--admin_email=${WP_ADMIN_EMAIL} \
						--allow-root \
						--path='/var/www/wordpress'

	wp user create		${WP_USER} \
						${WP_USER_EMAIL} \
						--role=author \
						--user_pass=${WP_USER_PASSWORD} \
						--allow-root

fi

#cat /var/www/wordpress/wp-config.php

echo "=> Starting php-fpm"
exec "$@"