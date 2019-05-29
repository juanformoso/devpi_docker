FROM juanformoso/ubuntu_python3_base

# install devpi server
RUN pip install devpi-server && pip install devpi-client

# this variable is also used by devpi-server itself
ENV DEVPISERVER_SERVERDIR /devpi/server
ENV DEVPISERVER_PORT 3141

RUN mkdir -p $DEVPISERVER_SERVERDIR

# copy dependency files
COPY devpi/* /devpi
RUN chmod u+x /devpi/bootstrap.sh

EXPOSE $DEVPISERVER_PORT

CMD ["/devpi/bootstrap.sh"]
