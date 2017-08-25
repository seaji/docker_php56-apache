#!/bin/sh
docker create \
    --name image_name \
    -v /local/path/to/www/folder:/var/www/html \
    -p 8080:80 \
    -e DB_HOSTIP=127.17.0.2 \
    -e DB_PORT=3306 \
    -e DB_DATABASE=mydatabase \
    -e DB_USERNAME=dbuser \
    -e DB_PASSWORD=dbuser \
    seaji/php56-apache:1.1
