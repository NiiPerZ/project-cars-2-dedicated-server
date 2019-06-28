FROM ubuntu:18.04

# Extract dedicated server files to /opt
COPY pc2ds.tar.gz /opt
RUN cd /opt && \
    tar -zxf pc2ds.tar.gz && \
    rm pc2ds.tar.gz

# Include server.cfg
COPY server.cfg /opt

WORKDIR /opt

EXPOSE 8766 27015 27016 9000

CMD /opt/DedicatedServerCmd.elf
