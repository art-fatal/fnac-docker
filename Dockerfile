FROM php:8.2-apache
LABEL authors="lafatra"

RUN apt update && apt-get upgrade

RUN apt-get install vim git-all zip unzip -y

RUN docker-php-ext-install mysqli

RUN apt-get install libzip-dev -y
RUN docker-php-ext-install zip

COPY apache/sites-available/* /etc/apache2/sites-available/

RUN a2ensite fnac.conf
RUN a2enmod rewrite

RUN docker-php-ext-install pdo_mysql

RUN apt-get install libicu-dev -y

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-enable intl

RUN apt-get install libonig-dev -y

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install exif
RUN docker-php-ext-install pcntl

RUN apt-get install -y libfreetype6-dev
RUN apt-get install -y libjpeg62-turbo-dev
RUN apt-get install -y libpng-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-enable gd

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

# COUCHE XDEBUG
RUN apt-get -y install gcc autoconf automake make tar

COPY php/xdebug-3.2.2.tgz /tmp/
RUN cd /tmp && \
    tar -xzf xdebug-3.2.2.tgz && \
    cd xdebug-3.2.2 && \
    phpize && \
    ./configure --enable-xdebug && \
    make && \
    make install

COPY php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
EXPOSE 80