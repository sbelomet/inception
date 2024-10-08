#!/bin/bash

apt list --installed | grep mysql

echo "=> Starting MariaDB server"
service mysql start

echo "=> Creating MariaDB database and user"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root' IDENTIFIED BY '$ROOT_PASSWORD';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "USE $DB_NAME;"

service mysql stop

exec "$@"