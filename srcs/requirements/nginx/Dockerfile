FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl

RUN rm -rf /var/lib/apt/lists/*

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx_inception.key \
	-out /etc/ssl/certs/nginx_inception.crt -subj "/C=CH/ST=Vaud/L=Lausanne/O=42/OU=42/CN=sbelomet.42.fr"

CMD ["nginx", "-g", "daemon off;"]