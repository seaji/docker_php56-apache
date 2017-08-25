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

    git clone https://github.com/seaji/docker_php56-apache.git php56-apache
    cd php56-apache
    docker build -t seaji/php56-apache:1.1 .
    
Опция -t задает тэг для образа, можете использовать свой. Формат - тэг:версия. На него вы будете ссылаться при создании контейнера.

__Пример создания контейнера из образа__
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

База данных уже должна работать, пользователь должен быть создан.
Переменные вы можете использовать в settings.php
Пример кода, который можно вставить в settings.php
    if(!empty($_ENV['DB_HOSTIP'])&&!empty($_ENV['DB_PORT'])&&!empty($_ENV['DB_DATABASE'])&&!empty($_ENV['DB_USERNAME'])&&!empty($_ENV['DB_PASSWORD'])){
      $databases = array (
      'default' => 
        array (
        'default' => 
        array (
          'database' => $_ENV['DB_DATABASE'],
          'username' => $_ENV['DB_USERNAME'],
          'password' => $_ENV['DB_PASSWORD'],
          'host' => $_ENV['DB_HOSTIP'],
          'port' => $_ENV['DB_PORT'],
          'driver' => 'mysql',
          'prefix' => '',
           ),
          ),
        );
      }
