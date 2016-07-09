## dockerized-dcm4chee-arc-light
Docker image that provides a DCM4CHEE 5.x. It needs MariaDB and LDAP containers, provided by https://github.com/opendicom/dockerized-mariadb-for-dcm4chee and https://github.com/opendicom/dockerized-slapd-for-dcm4chee.

There is a docker-compose file that bootstraps a complete PACS environment.

Based on https://github.com/dcm4che-dockerfiles/dcm4chee-arc-psql
