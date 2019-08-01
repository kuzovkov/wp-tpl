#!/bin/sh

###########################
# Store database to  dump #
###########################

DB_USER=wordpress
DB_PASS=userp@ssw0rd
DB_NAME=wordpress
DUMP_NAME=dump.sql.gz

sudo docker-compose exec db sh -c "mysqldump -u$DB_USER -p$DB_PASS $DB_NAME | gzip > /dump/$DUMP_NAME"