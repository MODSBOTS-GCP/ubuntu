FROM ubuntu:18.04
RUN apt-get update && apt-get install -y autoconf automake curl cmake git libtool make \
    && git clone --depth=1 https://github.com/tsl0922/ttyd.git /ttyd \
    && cd /ttyd && env BUILD_TARGET=x86_64 ./scripts/cross-build.sh

FROM alpine
COPY --from=0 /ttyd/build/ttyd /usr/bin/ttyd
RUN apk add --no-cache bash tini

EXPOSE 8080
WORKDIR /root

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ttyd", "bash"]
