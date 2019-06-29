FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y ca-certificates

# Extract dedicated server files to /opt
COPY pc2ds.tar.gz /opt
RUN cd /opt && \
    tar -zxf pc2ds.tar.gz && \
    rm pc2ds.tar.gz

# Include server.cfg
COPY server.cfg /opt

WORKDIR /opt

EXPOSE 8766 27015 27016 80

CMD /opt/DedicatedServerCmd.elf
