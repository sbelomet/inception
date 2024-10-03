FROM debian:bullseye

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget php-fpm php-mysql mariadb-client sendmail

RUN rm -rf /var/lib/apt/lists/*

