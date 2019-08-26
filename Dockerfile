ARG USER=mysql
FROM liammartens/alpine:3.10
LABEL maintainer="Liam Martens <hi@liammartens.com>"

# @user Use root user for install
USER root

# @run Install packages
RUN apk add --update pwgen mariadb mariadb-client

# @run Create mysql directories
RUN mkdir -p /var/lib/mysql /run/mysqld /etc/mysql

# @copy Copy default config file
COPY conf/ /etc/mysql

# @run Chown mysql directories
RUN chown -R ${USER}:${USER} /var/lib/mysql /run/mysqld /etc/mysql

# @copy Copy additional run files
COPY .docker ${DOCKER_DIR}

# @run Make the file(s) executable
RUN chmod -R +x ${DOCKER_DIR}

# @user Switch back to non-root user
USER ${USER}

# @cmd Set command to start the mysql server
CMD [ "-c", "mysqld" ]