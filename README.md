__Создает образ докера со следующими компонентами:__

* debian:jessie
* apache2
* php 5.6
* zip
* mysql-client
* git
* composer 1.5.1
* drush 8
* laravel/installer

__Пример сборки образа__

git clone 
docker build -t seaji/php56-apache:1.1 .