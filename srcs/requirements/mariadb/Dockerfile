FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server

COPY /mdb-conf.sh /mdb-conf.sh
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf


RUN chmod +x /mdb-conf.sh

EXPOSE 3306

CMD ["./mdb-conf.sh"]