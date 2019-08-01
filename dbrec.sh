#!/bin/sh

###############################
# Recovery database from dump #
###############################

DB_USER=wordpress
DB_PASS=userp@ssw0rd
DB_NAME=wordpress
DUMP_NAME=dump.sql.gz

sudo docker-compose exec db mysql -u$DB_USER -p$DB_PASS -e "DROP DATABASE IF EXISTS $DB_NAME"
sudo docker-compose exec db mysql -u$DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME"
sudo docker-compose exec db sh -c "gunzip < /dump/$DUMP_NAME | mysql -u$DB_USER -p$DB_PASS $DB_NAME"
