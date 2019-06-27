#!/bin/bash


cd /var/www/html/wordpress
sed -i "s/database_name_here/$DB_NAME/g" wp-config.php
sed -i "s/username_here/$DB_USER/g" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/g" wp-config.php
sed -i "s/db_host_here/$DB_HOST/g" wp-config.php

/usr/sbin/httpd -DFOREGROUND

#tail -f /dev/null