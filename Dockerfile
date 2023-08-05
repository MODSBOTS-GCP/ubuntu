FROM ubuntu:20.04
RUN mkdir ./app
RUN chmod 777 ./app
WORKDIR /app

RUN apt -qq update

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

RUN apt -qq install -y git aria2 wget curl busybox unzip unrar tar tmux tmate sudo systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in ; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);

RUN rm -rf /lib/systemd/system/multi-user.target.wants/ \
    && rm -rf /etc/systemd/system/.wants/ \
    && rm -rf /lib/systemd/system/local-fs.target.wants/ \
    && rm -f /lib/systemd/system/sockets.target.wants/udev \
    && rm -f /lib/systemd/system/sockets.target.wants/initctl \
    && rm -rf /lib/systemd/system/basic.target.wants/ \
    && rm -f /lib/systemd/system/anaconda.target.wants/*

COPY . .

RUN wget https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64
RUN chmod +x ttyd.x86_64
CMD ./ttyd.x86_64 -p 8080 bash
