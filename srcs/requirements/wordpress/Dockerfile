FROM debian:bullseye

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget php-fpm php-mysql mariadb-client sendmail

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 9000

RUN wget https://wordpress.org/wordpress-6.5.tar.gz -P var/www/ && \
	cd /var/www/ && \
	tar -xvf wordpress-6.5.tar.gz && \
	rm -rf wordpress-6.5.tar.gz

COPY ./tools/entrypoint_wordpress.sh /usr/local/bin/entrypoint.sh
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/php-fpm7.3", "-F"]