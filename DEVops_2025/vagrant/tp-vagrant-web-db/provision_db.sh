#!/bin/bash
set -e

#mise a jour des paquet
apt update 
#installation de mariadb
apt install -y mariadb-server

# Configure MariaDB pour écouter sur toutes les interfaces
sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf || true

# Active MariaDB au démarrage et redémarre le service
systemctl enable mariadb
systemctl restart mariadb

# Executer le scrit
mariadb < /vagrant/db_sql/db_init.sql



