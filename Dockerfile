# set 
ARG USER='mysql'
FROM liammartens/alpine
LABEL maintainer="hi@liammartens.com"
# set environments
ENV OWN_BY='mysql:mysql'
ENV OWN_DIRS="${ENV_DIR} /var/lib/mysql /etc/mysql"

# add packages
RUN apk add pwgen mariadb mariadb-client

# purge and re-create /var/lib/mysql with appropriate ownership
RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R ${USER}:${USER} /var/lib/mysql /run/mysqld

# set mysql volumes
VOLUME /var/lib/mysql /etc/mysql

# copy continue file
COPY scripts/continue.sh ${ENV_DIR}/scripts/continue.sh
RUN chmod +x ${ENV_DIR}/scripts/continue.sh