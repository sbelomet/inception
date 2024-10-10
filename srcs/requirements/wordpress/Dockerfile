FROM debian:bullseye

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget mariadb-client php7.4 php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-intl php7.4-mbstring php7.4-soap php7.4-xml php7.4-xmlrpc php7.4-zip

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 9000

#RUN wget https://wordpress.org/wordpress-6.5.tar.gz -P var/www/ && \
#	cd /var/www/ && \
#	tar -xvf wordpress-6.5.tar.gz && \
#	rm -rf wordpress-6.5.tar.gz

COPY ./tools/entrypoint_wordpress.sh /usr/local/bin/entrypoint.sh
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["php-fpm7.4", "-F"]