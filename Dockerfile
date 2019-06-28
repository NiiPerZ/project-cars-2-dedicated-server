FROM ubuntu:18.04 AS stubby
RUN apt-get update && \
    apt-get install -y wget
RUN cd /opt && \
    wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zx && \
    ls -la
RUN /opt/steamcmd.sh
CMD /bin/sh
