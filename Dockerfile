FROM ubuntu:18.04 AS stubby
RUN apt-get update && \
    apt-get install -y wget \
                       lib32gcc1
RUN cd /opt && \
    wget -qO- /opt https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zx
RUN ls -la /opt
RUN /opt/steamcmd.sh +login anonymous +force_install_dir /srv +app_update 413770 -validate
RUN ls -la /srv
CMD /bin/sh
