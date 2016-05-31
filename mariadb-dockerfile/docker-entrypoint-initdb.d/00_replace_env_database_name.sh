#!/bin/bash

# Replace database name placeholder with the name defined in env variable (MYSQL_DATABASE).
# This allows to define a custom name for the PACS database when starting a container.
# The script is executed from the "docker-entrypoint.sh" script, and because
# it starts with "00" it goes before the *.sql files defining the schema.

sed -i "s/ENV_PLACEHOLDER.MYSQL_DATABASE/$MYSQL_DATABASE/g" /docker-entrypoint-initdb.d/*.sql
