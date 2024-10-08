#!/bin/bash

if [ ! -d /var/www/wordpress ]; then
	mkdir -p /var/www/wordpress
fi

if [ -f /var/www/wordpress/wp-config.php ]; then
	exec "$@"
	exit 0
fi

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

chown -R root:root /var/www/wordpress
cd /var/www/wordpress

wp config create	--allow-root \
					--dbname=$DB_NAME \
					--dbuser=$DB_USER \
					--dbpass=$DB_USER_PASSWORD \
					--dbhost=$DB_HOST \
					--path='/var/www/wordpress'

wp core install		--url=$WP_URL \
					--title=$WP_TITLE \
					--admin_user=$WP_ADMIN_USER \
					--admin_password=$WP_ADMIN_PASSWORD \
					--admin_email=$WP_ADMIN_EMAIL \
					--allow-root \
					--path='/var/www/wordpress'

wp user create		$WP_USER \
					$WP_USER_EMAIL \
					--role=author \
					--user_pass=$WP_USER_PASSWORD \
					--allow-root

if [ ! -d /run/php ]; then
	mkdir -p /run/php
fi

exec "$@"