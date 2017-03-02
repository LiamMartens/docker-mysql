#!/bin/sh
chown -R mysql:mysql /var/lib/mysql /etc/mysql
exec "$@"