FROM mariadb:10.1.14

ENV DCM4CHEE_ARC_VERSION="5.3.1"
ENV DCM4CHE_VERSION="dcm4chee-arc-$DCM4CHEE_ARC_VERSION-mysql"

# install software needed to download and decompress binary distribution of dcm4chee-arc
RUN apt-get update && apt-get install curl unzip

# download binary distribution to use sql files
RUN curl -O -L https://sourceforge.net/projects/dcm4che/files/dcm4chee-arc-light5/$DCM4CHEE_ARC_VERSION/$DCM4CHE_VERSION.zip \
    && unzip $DCM4CHE_VERSION.zip \
    && cp $DCM4CHE_VERSION/sql/create-mysql.sql docker-entrypoint-initdb.d/10_create-mysql.sql \
    && cp $DCM4CHE_VERSION/sql/create-fk-index.sql docker-entrypoint-initdb.d/20_create-fk-index.sql

COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/

RUN chmod 777 -Rf /docker-entrypoint-initdb.d
