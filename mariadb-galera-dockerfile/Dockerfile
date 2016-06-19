### sources:
# http://galeracluster.com/2015/05/getting-started-galera-with-docker-part-1/
# https://www.digitalocean.com/community/tutorials/how-to-configure-a-galera-cluster-with-mariadb-on-ubuntu-12-04-servers
# https://mariadb.com/kb/en/mariadb/installing-mariadb-deb-files/
# https://github.com/docker-library/mariadb/tree/master/10.1

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND='noninteractive'
ENV MARIADB_VERSION='10.0'

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

# install needed software
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db \
    && apt-get update \
    && apt-get install -y software-properties-common rsync \
    && apt-add-repository "deb http://ftp.osuosl.org/pub/mariadb/repo/${MARIADB_VERSION}/ubuntu trusty main" \
    && apt-get update \
    && apt-get install -y mariadb-galera-server galera-3 galera-arbitrator-3

# default configuration file
COPY my.cnf /etc/mysql/my.cnf

# directories and permissions
RUN rm -rf /var/lib/mysql \
    && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld
VOLUME /var/lib/mysql

# entrypoint
RUN mkdir /docker-entrypoint-initdb.d
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# copy sql files from version 5.3.1
COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/
RUN chmod 777 -Rf /docker-entrypoint-initdb.d

EXPOSE 3306
CMD ["mysqld"]
