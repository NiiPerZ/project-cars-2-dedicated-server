FROM ubuntu:18.04 AS stubby
RUN --mount=type=secret,id=steam_username
RUN cat /run/secrets/steam_username
RUN apt-get update && \
    apt-get install -y wget \
                       lib32gcc1
RUN cd /opt && \
    wget -qO- /opt https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zx
RUN ls -la /opt
RUN echo $STEAM_USERNAME
RUN /opt/steamcmd.sh +login $STEAM_USERNAME $STEAM_PASSWORD +force_install_dir /srv +app_update 413770 validate +quit
RUN ls -la /srv
CMD /bin/sh
