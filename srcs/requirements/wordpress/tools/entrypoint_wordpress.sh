#!/bin/bash

mkdir -p /run/php

if [ -f /var/www/html/wp-config.php ]; then
	exec "$@"
	exit 0
fi

cd /var/www/worpress

wp core download	--allow-root
wp config create	--dbname=$DB_NAME \
					--dbuser=$DB_USER \
					--dbpass=$DB_USER_PASSWORD \
					--dbhost=$DB_HOST \
					--allow-root \
					--path='/var/www/worpress'

wp core install		--url=$WP_URL \
					--title=$WP_TITLE \
					--admin_user=$WP_ADMIN_USER \
					--admin_password=$WP_ADMIN_PASSWORD \
					--admin_email=$WP_ADMIN_EMAIL \
					--allow-root

wp user create		$WP_USER \
					$WP_USER_EMAIL \
					--role=author \
					--user_pass=$WP_USER_PASSWORD \
					--allow-root

exec "$@"