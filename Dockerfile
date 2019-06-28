FROM ubuntu:18.04 AS stubby
RUN ls -la
RUN cd /opt && \
    ls -la
RUN ls -la
CMD /bin/sh
