FROM debian:bullseye

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install mariadb-server

RUN rm -rf /var/lib/apt/lists/*

COPY ./