FROM php:8.2-apache
LABEL authors="lafatra"

RUN apt update && apt-get upgrade && apt-get install vim -y

RUN docker-php-ext-install mysqli

EXPOSE 80