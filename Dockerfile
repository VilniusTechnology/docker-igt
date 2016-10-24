FROM php:5.5-fpm

MAINTAINER "Lukas Mikelionis" <lukas.mikelionis@vilnius.technology>

# Install modules
RUN apt-get update \
    && apt-get install --fix-missing -y \
    git \
    php-pear \
    zziplib-bin \
    libmcrypt-dev  \
    libicu-dev \
    mysql-client \
    zlib1g-dev \
    nodejs-legacy \
    npm \
    ant \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install mysql \
    && docker-php-ext-install iconv \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-install sockets \
    && docker-php-ext-install mbstring
    && pecl install  "channel://pecl.php.net/zip-1.5.0" \
    xdebug \
    mongo

# Deploy php's dependency manager composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && PATH=$PATH:/root/.composer/vendor/bin

RUN npm install -g bower gulp

ADD ./entrypoint/entrypoint.sh /entrypoint/entrypoint.sh
ADD ./ini/php.ini /usr/local/etc/php/php.ini

VOLUME ["/var/www/"]

CMD ["/entrypoint/entrypoint.sh"]
