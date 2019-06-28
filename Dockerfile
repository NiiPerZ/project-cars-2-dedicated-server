# syntax = docker/dockerfile:1.0-experimental
FROM ubuntu:18.04 AS steamcmd
RUN apt-get update && \
    apt-get install -y wget \
                       lib32gcc1
RUN cd /opt && \
    wget -qO- /opt https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zx
RUN ls -la /opt
RUN --mount=type=secret,id=steam_username
RUN --mount=type=secret,id=steam_password
RUN ls -la /run/secrets
RUN /opt/steamcmd.sh +login $(cat /run/secrets/steam_username) $(cat /run/secrets/steam_password) +force_install_dir /srv +app_update 413770 validate +quit
RUN ls -la /srv
CMD /bin/sh
