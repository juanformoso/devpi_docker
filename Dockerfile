FROM ubuntu:18.04

# upgrade installed packages
RUN apt-get update && apt-get upgrade -y && apt-get clean

# python package management and basic dependencies
RUN apt-get install -y python3.6 python3.6-dev python3-pip

# Register the version in alternatives
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1

# Set python 3 as the default python
RUN update-alternatives --set python /usr/bin/python3.6

# Upgrade pip version
RUN python -m pip install pip --upgrade --force-reinstall

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
