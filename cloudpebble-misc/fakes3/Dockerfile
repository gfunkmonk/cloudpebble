#FROM ruby:2.5-alpine3.8
#FROM andrius/alpine-ruby:3.10
FROM alpine:3.10

RUN umask 0000

##ARG HOST_NAME=s3.amazonaws.com
ARG HOST_NAME=s3-us-east-2.amazonaws.com
ENV FAKES3_VERSION 2.0.0
#ENV FAKES3_VERSION 1.2.1
#ENV FAKES3_VERSION 1.2.0
#ENV FAKES3_VERSION 0.2.4

RUN mkdir -p /fakes3_root && chown -R nobody:nobody /fakes3_root && \
  chmod 0750 /fakes3_root

WORKDIR /fakes3_root
VOLUME ["/fakes3_root"]

EXPOSE 4569

RUN apk --no-cache add ruby ruby-io-console ruby-etc && \
  #gem install --no-document fakes3 -v ${FAKES3_VERSION} && \
  gem install --no-rdoc --no-ri webrick && \
  gem install --no-rdoc --no-ri fakes3 -v ${FAKES3_VERSION} && \
  rm -rf /var/cache/apk/*

ENTRYPOINT ["fakes3", "-r", "/fakes3_root", "-p", "4569", "--license", "$FAKES3_KEY"]
#ENTRYPOINT ["fakes3", "-r", "/fakes3_root", "-p", "4569"]

