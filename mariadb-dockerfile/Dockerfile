FROM mariadb:10.1.14

# copy sql files from version 5.3.1
COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/

RUN chmod 777 -Rf /docker-entrypoint-initdb.d
