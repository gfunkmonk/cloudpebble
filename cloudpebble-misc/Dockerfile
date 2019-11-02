FROM andrius/alpine-ruby:3.6

ARG HOST_NAME=s3.amazonaws.com
ENV FAKES3_VERSION 2.0.0
ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data
ENV REDIS_VERSION=4.0.2

#WORKDIR /fakes3_root

VOLUME ["/fakes3_root"]
VOLUME ["/var/lib/postgresql/data"]
VOLUME ["/data"]

EXPOSE 4569
EXPOSE 5432
EXPOSE 6379

RUN echo "@v37 http://nl.alpinelinux.org/alpine/v3.7/main" >> /etc/apk/repositories && apk update && \
    apk add --no-cache redis supervisor && mkdir -p /fakes3_root && chown nobody:nobody /fakes3_root && chmod 0750 /fakes3_root && \
    apk add --no-cache curl "libpq@v37<10.11" "postgresql-client@v37<10.11" "postgresql@v37<10.11" "postgresql-contrib@v37<10.11" \
    ruby-io-console ruby && gem install --no-rdoc --no-ri fakes3 -v ${FAKES3_VERSION} && apk add --no-cache --virtual .build-deps \
    build-base linux-headers openssl && mkdir -p /docker-entrypoint-initdb.d && \
    curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && mkdir -p /data && chown -R redis:redis /data && cd /tmp \
    && wget https://github.com/antirez/redis/archive/${REDIS_VERSION}.tar.gz && tar xzf ${REDIS_VERSION}.tar.gz \
    && cd /tmp/redis-${REDIS_VERSION} && make && make install && apk del .build-deps && rm  -rf /tmp/* /var/cache/apk/* && rm -rf /tmp/*

COPY postgres.sh /usr/local/bin/postgres.sh
ADD redis.conf /etc/redis.conf
ADD supervisord.conf /etc/

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
