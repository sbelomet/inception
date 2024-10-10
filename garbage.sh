#!/bin/bash

echo "=> Starting MariaDB server"
service mariadb start
sleep 5
echo "=> Creating MariaDB database and user"
#mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';"
#mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root' IDENTIFIED BY '$ROOT_PASSWORD';"
#mysql -u root -e "FLUSH PRIVILEGES;"
#mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
#echo "1"
#mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
#echo "2"
#mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
#echo "3"
#mysql -u root -e "USE $DB_NAME;"
#mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';"
#mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root' IDENTIFIED BY '$DB_ROOT_PASSWORD';"
#mysql -e "FLUSH PRIVILEGES;"
#mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown
mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS_ROOT';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');
EOF
sleep 5
echo "=> Done!"

exec mysqld_safes



service mariadb start
sleep 5
echo "=> Creating MariaDB database and user"
#mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';"
#mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root' IDENTIFIED BY '$ROOT_PASSWORD';"
#mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
mysql -u root -e "FLUSH PRIVILEGES;"
#mysql -u root -e "USE $DB_NAME;"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';"
mysqladmin -u root -p$ROOT_PASSWORD shutdown
echo "=> Done!"