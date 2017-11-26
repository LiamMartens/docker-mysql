#!/bin/sh
export HOME=/home/mysql

if [ -z "$MYSQL_PORT" ]; then
	export MYSQL_PORT=3306
fi

if [ -z "$TIMEZONE" ]; then
	export TIMEZONE='UTC'
fi

# set timezone
cat /usr/share/zoneinfo/$TIMEZONE > /etc/localtime
echo $TIMEZONE > /etc/timezone

if [ ! -d '/var/lib/mysql/mysql' ]; then

	echo 'Initializing database'
	mysql_install_db --user=$USER
	echo 'Database initialized'

	echo "Starting MySQL on port $MYSQL_PORT"
	/usr/share/mysql/mysql.server start --user=$USER --port=$MYSQL_PORT

	MYSQL_PASSWORD="$(pwgen -ncB 32 1)"
	mysql -u root <<-EOSQL
DELETE FROM mysql.user;
CREATE USER 'root'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
SET PASSWORD FOR 'root'@'%' = PASSWORD('$MYSQL_PASSWORD');
GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOSQL
	echo "GENERATED ROOT PASSWORD: $MYSQL_PASSWORD"
	echo $MYSQL_PASSWORD > /etc/mysql/.passwd
else
	echo "Starting MySQL on port $MYSQL_PORT"
	/usr/share/mysql/mysql.server start --user=$USER --port=$MYSQL_PORT
fi

# run user scripts
if [[ -d ./files/.$(whoami) ]]; then
	chmod +x ./files/.$(whoami)/*
	run-parts ./files/.$(whoami)
fi

$SHELL