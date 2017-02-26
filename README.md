# Custom MariaDB docker image
* Based on Alpine
* Runs as mysql user internally after taking file ownership
* Defines 2 volumes (/var/lib/mysql for data storage and /etc/mysql for the configuration)
* Sets timezone to environment variable TIMEZONE or to UTC by default
* Aside from mariaDB also includes some useful tools such as htop, curl and so on (but no build tools)
* Generates random root password upon first runn (will keep doing so if no persistent storage volume is used)
* Binds MariaDB to port 3306 by default but can be overriden by setting a MYSQL_PORT environment variable