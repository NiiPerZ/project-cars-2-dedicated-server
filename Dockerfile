FROM ubuntu:18.04

# Extract dedicated server files to /opt
COPY pc2ds.tar.gz /opt
RUN cd /opt && \
    tar -zxf pc2ds.tar.gz && \
    rm pc2ds.tar.gz

CMD /opt/DedicatedServerCmd.elf
