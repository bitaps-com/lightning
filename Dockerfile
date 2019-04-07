FROM ubuntu:18.04
MAINTAINER Aleksey Karpov <admin@bitaps.com>
RUN apt-get update
RUN apt-get -y install git
RUN git clone https://github.com/ElementsProject/lightning -v
RUN cd lightning;git checkout "v0.7.0";
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y tzdata;ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime; \
    dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get -y install autoconf automake build-essential git libtool libgmp-dev \
               libsqlite3-dev python python3 net-tools zlib1g-dev libsodium-dev \
               libbase58-dev
RUN apt-get -y install asciidoc valgrind python3-pip
RUN pip3 install -r lightning/tests/requirements.txt
RUN cd lightning;./configure;make
RUN cd lightning;make install
