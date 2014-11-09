FROM ubuntu:bionic
ENV DEBIAN_FRONTEND noninteractive

ADD basic_debian_setup.sh /
RUN /basic_debian_setup.sh && rm /basic_debian_setup.sh

RUN add-apt-repository ppa:freecad-maintainers/freecad-stable&&\
    apt update&&\
    apt install -y freecad
