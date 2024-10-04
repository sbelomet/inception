FROM debian:bullseye

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget php-fpm php-mysql mariadb-client sendmail

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 9000

COPY ./tools/entrypoint_wordpress.sh /usr/local/bin/entrypoint.sh
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN chmod +x /usr/local/bin/entrypoint.sh

RUN wget https://wordpress.org/wordpress-6.5.tar.gz && \
	tar -xvf wordpress-6.5.tar.gz && \
	rm -rf wordpress-6.5.tar.gz && \
	mv wordpress /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN chown -R www-data:www-data /var/www/wordpress

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["php-fpm7.3", "-F"]