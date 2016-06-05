#!/bin/bash

# Replace database name placeholder with the name defined in env variable (MYSQL_DATABASE).
# This allows to define a custom name for the PACS database when starting a container.
# The script is executed from the "docker-entrypoint.sh" script, and because
# it starts with "00" it goes before the *.sql files defining the schema.

for file in /docker-entrypoint-initdb.d/*.sql; do
    content=`cat $file`
    echo "use $MYSQL_DATABASE;" > $file
    echo $content >> $file
done
