FROM debian:bullseye

RUN apt-get update && apt-get -y upgrade
RUN apt-get purge -y mysql-server mysql-common && \
	apt-get purge -y mysql-client && \
	apt-get autoremove -y mysql-server mysql-client mysql-common && \
	apt-get autoclean -y mysql-seerver mysql-client mysql-common
RUN apt-get install -y mariadb-server mysql-common

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && \
	mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/entrypoint_mariadb.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mysqld_safe"]