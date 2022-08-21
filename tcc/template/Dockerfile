FROM alpine:latest

RUN cat /etc/resolv.conf && apk update && apk add texlive-full

WORKDIR /data
VOLUME ["/data"]