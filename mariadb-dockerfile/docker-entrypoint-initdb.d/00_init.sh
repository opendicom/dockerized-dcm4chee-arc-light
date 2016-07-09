#!/bin/bash

# Execute custom actions on startup. The script name starts with "00",
# so it gets executed before the *.sql files defining the schema.

# Use environmental variables to configure replication
if [ -n "$WSREP_ON" ]; then
    # Create configuration file
    config_file='/etc/mysql/conf.d/server.cnf'
    echo "[galera]" >> $config_file
    echo "wsrep_on = ON" >> $config_file
    echo "wsrep_debug = ON" >> $config_file
    echo "wsrep_provider = /usr/lib/galera/libgalera_smm.so" >> $config_file
    echo "wsrep_sst_method = xtrabackup" >> $config_file
    echo "wsrep_cluster_name = "$WSREP_CLUSTER_NAME >> $config_file
    echo "wsrep_cluster_address = "$WSREP_CLUSTER_ADDRESS >> $config_file
    echo "wsrep_sst_auth = "$REPLICATION_USER":"$REPLICATION_PASSWORD >> $config_file
    echo "wsrep_node_address = "$WSREP_NODE_ADDRESS >> $config_file
    echo "wsrep_node_name = "$WSREP_NODE_NAME >> $config_file

    # Create .sql file containing replication user
    replication_file='/docker-entrypoint-initdb.d/30_replication_user.sql'
    echo "GRANT USAGE ON *.* to '$REPLICATION_USER'@'%' IDENTIFIED BY '$REPLICATION_PASSWORD';" >> $replication_file;
    echo "GRANT ALL PRIVILEGES on *.* to '$REPLICATION_USER'@'%';" >> $replication_file
    echo "FLUSH PRIVILEGES;" >> $replication_file
fi

# Allow to define a custom name for the PACS database when starting a
# container using MYSQL_DATABASE environmental variable
cd /docker-entrypoint-initdb.d/ && for file in *.sql; do
    echo "use $MYSQL_DATABASE;" > tmp.sql
    cat $file >> tmp.sql
    rm $file
    mv tmp.sql $file
done
