# Project CARS 2 - Dedicated Server

## Update pc2ds.tar.gz (Ubuntu)
Due to Steam Guard it's not recommended to fetch dedicated server files during
Docker image build, so pc2ds.tar.gz is used to contain these files instead.

These are the commands to run in Ubuntu to fetch an updated pc2ds.tar.gz file,
again it's recommended to run these in an interactive shell so password and more
importantly Steam Guard code can be entered if needed (might not be needed if
ran more than once, due to a cookie/token being created on the first run, that
steamcmd will utilise).

1. Specify an enviromental variable to hold your steam username
```
STEAM_USERNAME=steamusernamegoeshere
```

2. Fetch the updated file and tidy up
```
sudo apt install -y lib32gcc1 && \
mkdir /tmp/steamcmd && \
wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -zxC /tmp/steamcmd && \
/tmp/steamcmd/steamcmd.sh +login $STEAM_USERNAME +force_install_dir /tmp/steamcmd/pc2ds +app_update 413770 validate +quit && \
cd /tmp/steamcmd/pc2ds && \
tar -zcf /tmp/steamcmd/pc2ds.tar.gz * && \
cd - && \
mv /tmp/steamcmd/pc2ds.tar.gz . && \
rm -r /tmp/steamcmd && \
unset STEAM_USERNAME
```
