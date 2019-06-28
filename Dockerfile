# syntax = docker/dockerfile:1.0-experimental

# Files image
FROM ubuntu:18.04 AS files

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget \
                       lib32gcc1

# Get steamcmd to /opt
RUN wget -qO- /opt https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -zxC /opt

# Get files with steamcmd to /srv
RUN --mount=type=secret,id=steam_username \
    --mount=type=secret,id=steam_password \
    --mount=type=secret,id=steam_guard_code \
    /opt/steamcmd.sh +login $(cat /run/secrets/steam_username) $(cat /run/secrets/steam_password) $(cat /run/secrets/steam_guard_code) +force_install_dir /srv +app_update 413770 validate +quit

# Runtime image
FROM ubuntu:18.04

# Install dependencies
#RUN apk add libstdc++ \
#            libc6-compat \
#            gcompat
#
# Install glibc
#RUN apk --no-cache add ca-certificates wget && \
#    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
#    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk && \
#    apk add glibc-2.29-r0.apk && \
#    rm glibc-2.29-r0.apk

# Get files to /opt
COPY --from=files /srv /opt
RUN ls -la /opt
RUN ldd /opt/DedicatedServerCmd.elf
RUN /opt/DedicatedServerCmd.elf

CMD /opt/DedicatedServerCmd.elf
