FROM ubuntu:bionic
ENV DEBIAN_FRONTEND noninteractive

ADD basic_debian_setup.sh /
RUN /basic_debian_setup.sh && rm /basic_debian_setup.sh

RUN add-apt-repository ppa:dolphin-emu/ppa &&\
    apt update&&\
    apt install -y dolphin-emu-master

RUN add-apt-repository ppa:pcsx2-team/pcsx2-daily &&\
    apt update&&\
    apt install -y pcsx2-unstable libcap2-bin

RUN apt update&&\
    apt install -y higan
