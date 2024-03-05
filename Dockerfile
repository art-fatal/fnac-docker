FROM php:8.2-apache
LABEL authors="lafatra"

RUN apt update && apt-get upgrade

RUN apt-get install vim git-all zip unzip -y

RUN docker-php-ext-install mysqli

RUN apt-get install libzip-dev -y
RUN docker-php-ext-install zip

COPY apache/sites-available/* /etc/apache2/sites-available/

RUN a2ensite fnac.conf

EXPOSE 80