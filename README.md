###I. Install

```bash
git clone https://github.com/kuzovkov/wp-tpl mysite

cd mysite

./install-docker.sh #if docker is not installed

#build container
sudo docker-compose build

#run
sudo docker-compose up -d
#checking:
sudo docker-compose ps
http://localhost:8003/info.php

#download and unpack wordpress
./get-wp.sh

#install wordpress
http://localhost:8003/
```
Please use `dbname`, `dbuser`, `dbpass` from `docker-compose.yml`.

Set `db` as `dbhost`

###II. Developing

```bash
#dump database
./dbdump.sh
```

```bash
#recovery database
./dbrec.sh
```    

###III. Trobleshuting
    
Fixing "Unknown collation: ‘utf8mb4_unicode_520_ci"

```bash
sed -i 's/utf8mb4_unicode_520_ci/utf8mb4_unicode_ci/g' dump.sql
```

If wordpress ask you FTP account when new plugin install:

add line to `wp-config.php`

```php
define( 'FS_METHOD', 'direct' );
```