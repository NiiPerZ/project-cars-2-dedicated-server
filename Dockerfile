FROM ubuntu:18.04 AS stubby
RUN apt update && \
    apt install wget
RUN cd /opt && \
    wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zx && \
    ./steamcmd && \
    ls -la
CMD /bin/sh
