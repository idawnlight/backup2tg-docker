FROM alpine:3.18

RUN set -ex \
  && apk upgrade \
  && apk add --no-cache tzdata curl mysql-client postgresql15-client bash \
  && touch /var/log/backup.log \
  && echo "0 1 * * * bash backup.sh >> /var/log/backup.log" >> /etc/crontabs/root

COPY --chmod=755 *.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["tail", "-f", "/var/log/backup.log"]