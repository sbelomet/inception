#!/bin/sh

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

	until mysqladmin ping 2> /dev/null; do
		sleep 2
	done

	mysql -u root <<EOF
		CREATE DATABASE IF NOT EXISTS ${DB_NAME};
		
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
		
		DELETE FROM mysql.user WHERE user='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		DELETE FROM mysql.user WHERE user='';
		
		CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
		GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
		
		FLUSH PRIVILEGES;
EOF

	if [ $? -ne 0 ]; then
		echo "Error: MySQL commands failed." >&2
		exit 1
	fi

	killall mysqld 2> /dev/null
fi

exec "$@"