# MariaDB
This image is built on `Alpine`.

## Build arguments
* `USER`: The non-root user to be used in the container (`mysql`by default)
* Any build arguments from the `Alpine` base image [liammartens/alpine](https://hub.docker.com/r/liammartens/alpine/)

## Volumes
* `/var/lib/mysql`: For persistent data 
* `etc/mysql : For configuration (default `my.cnf` is copied if no volume is used)

## Environment
You can control the MariaDB port by passing the `MYSQL_PORT` environment variable. Furthermore you can use any environment variables defined in the official [MariaDB container](https://hub.docker.com/_/mariadb/) as the initialization script is the mostly the same. The only difference is the fact that generating a random root password is the preferred method for creating a password and does not need to be explicitly enabled and the generated password is not only printed to the terminal as it is also saved to `/etc/mysql/.passwd`.