FROM alpine:3.13.5
MAINTAINER chosnf
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.license=GPL-2.0 \
    org.label-schema.name=nut-upsd \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url=https://github.com/instantlinux/docker-tools

ENV API_USER=monuser \
    DESCRIPTION=UPS \
    DRIVER=blazer_ser \
    NAME=ups \
    POLLINTERVAL=5 \
    PORT=/dev/ttyUSB0 \
    API_PASSWORD=secret \
    API_SERVER=slave \
    USER=nut

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
      >>/etc/apk/repositories && \
    apk add --update nut@testing \
      libcrypto1.1 libssl1.1 net-snmp-libs

EXPOSE 3493
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT /usr/local/bin/entrypoint.sh
