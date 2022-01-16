FROM docker.io/alpine:3.15

RUN set -ex \
  && apk upgrade \
  && apk add --no-cache tzdata curl mysql-client postgresql14-client bash \
  && touch /var/log/backup.log \
  && echo "0 1 * * * bash backup.sh >> /var/log/backup.log" >> /etc/crontabs/root

COPY *.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["tail", "-f", "/var/log/backup.log"]