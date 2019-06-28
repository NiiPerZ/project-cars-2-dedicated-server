# syntax = docker/dockerfile:1.0-experimental
FROM ubuntu:18.04 AS dedicated-server

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget \
                       lib32gcc1

# Get steamcmd to /opt
RUN wget -qO- /opt https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -zxC /opt
RUN ls -la /opt

# Get dedicated server files with steamcmd to /srv
RUN --mount=type=secret,id=steam_username \
    --mount=type=secret,id=steam_password \
    --mount=type=secret,id=steam_guard_code \
    /opt/steamcmd.sh +login $(cat /run/secrets/steam_username) $(cat /run/secrets/steam_password) $(cat /run/secrets/steam_guard_code) +force_install_dir /srv +app_update 413770 validate +quit
RUN ls -la /srv

# Use multi-stage build to compress layers for a smaller image
FROM alpine:3.10
COPY --from=dedicated-server /srv /opt
RUN ls -la /opt
CMD /bin/sh
