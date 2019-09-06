#!/bin/sh

###############################
# Recovery database from dump #
###############################

DB_USER=root
DB_PASS=rootroot
DB_NAME=wordpress
DUMP_NAME=dump.sql.gz

#############################
## Change site URL:
## UPDATE  `wp1`.`wp_options` SET  `option_value` =  'http://yousite.ru' WHERE  `wp_options`.`option_name` =`siteurl`;
## UPDATE  `wp1`.`wp_options` SET  `option_value` =  'http://yousite.ru' WHERE  `wp_options`.`option_name` =`home`;
##########################################
##  mysql -uroot -prootroot -e "USE wp1; UPDATE  wp1.wp_options SET option_value= 'http://yousite.ru' WHERE wp_options.option_name ='siteurl';"
##   mysql -uroot -prootroot -e "USE wp1; UPDATE  wp1.wp_options SET option_value= 'http://yousite.ru' WHERE wp_options.option_name ='home';"
###########################################################
case "$1" in
  filldb)
    echo "Fill db"
    mysql -u$DB_USER -p$DB_PASS -e "DROP DATABASE IF EXISTS $DB_NAME"
    mysql -u$DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME"
    /bin/sh -c "gunzip < ./db/dump/$DUMP_NAME | mysql -u$DB_USER -p$DB_PASS $DB_NAME"
    ;;
  seturl)
    echo "Setting site URL '$2'"
    mysql -u$DB_USER -p$DB_PASS -e "USE $DB_NAME; UPDATE  $DB_NAME.wp_options SET option_value= '$2' WHERE wp_options.option_name ='siteurl';"
    mysql -u$DB_USER -p$DB_PASS -e "USE $DB_NAME; UPDATE $DB_NAME.wp_options SET option_value= '$2' WHERE wp_options.option_name ='home';"
    ;;

  fixdb)
        echo "Fix 'Unknown collation: ‘utf8mb4_unicode_520_ci'"
        mysql -u$DB_USER -p$DB_PASS -e "DROP DATABASE IF EXISTS $DB_NAME"
        mysql -u$DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME"
        cd db/dump
        gunzip $DUMP_NAME
        sed -i 's/utf8mb4_unicode_520_ci/utf8mb4_unicode_ci/g' dump.sql
        cat dump.sql | mysql -u$DB_USER -p$DB_PASS $DB_NAME
    esac