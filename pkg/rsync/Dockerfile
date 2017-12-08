FROM linuxkit/alpine:585174df463ba33e6c0e2050a29a0d9e942d56cb
LABEL maintainer="Erno Aapa <erno.aapa@gmail.com>"
RUN apk add --no-cache \
  musl \
  libacl \
  popt \
  rsync

ENTRYPOINT []
CMD []
WORKDIR /
EXPOSE 873
ADD ./entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
