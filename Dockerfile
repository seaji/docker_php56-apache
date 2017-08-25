FROM php:5.6-apache

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /root/.composer
ENV COMPOSER_VERSION 1.5.1

RUN apt-get update \
    && apt-get install -y libpng-dev zip unzip mysql-client git\
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && docker-php-ext-enable pdo pdo_mysql mysqli \
    && docker-php-ext-install gd \
    && docker-php-ext-enable gd \
    && a2enmod rewrite \
    && echo 'Europe/Moscow' > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata;

RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/da290238de6d63faace0343efbdd5aa9354332c5/web/installer \
    && php -r " \
    \$signature = '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410'; \
    \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
    if (!hash_equals(\$signature, \$hash)) { \
        unlink('/tmp/installer.php'); \
        echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
        exit(1); \
    }" \
 && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
 && composer --ansi --version --no-interaction \
 && composer global require drush/drush:8.* \
 && ln -s /root/.composer/vendor/drush/drush/drush /usr/local/bin/drush \
 && composer global require "laravel/installer";
