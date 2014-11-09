#!/usr/bin/env bash

# everyone can use sudo
# to get sound, we must have pulse audio installed
# to get vulkan, we must have mesa drivers installed
# allows to get autocomplete for package install inside container

# automatize deletion of statoverride file, that may cause issues when
# installing package using another user than root

dpkg --add-architecture i386 &&
mkdir /etc/sudoers.d/ &&
echo "ALL ALL=(root) NOPASSWD:ALL" >> /etc/sudoers.d/all &&
chmod 0440 /etc/sudoers.d/all &&
apt update &&
apt install -y\
    alsa-utils\
    apt-utils \
    bash-completion \
    coreutils \
    elinks \
    ffmpeg \
    git \
    htop \
    imagemagick \
    iptables \
    locales-all \
    lsof \
    mesa*drivers\
    mesa-utils\
    net-tools \
    pulseaudio\
    ncdu \
    software-properties-common \
    rsync \
    strace \
    sudo \
    tig \
    time \
    tree \
    tmux \
    vim-gtk \
    vulkan-utils \
    x11-apps \
    xclip \
    xz-utils \
    zip \
    wget &&
apt upgrade -y &&
echo "DPkg::Post-Invoke { \"rm -f /var/lib/dpkg/statoverride || true\"; };" >>\
   /etc/apt/apt.conf.d/statoverride-clean &&
rm /etc/apt/apt.conf.d/docker-clean && apt update

# tmux reads that file that erases PATH
rm -f /etc/profile
