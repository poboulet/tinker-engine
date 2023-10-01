# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set the working directory in docker
WORKDIR /app

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    software-properties-common \
    wget \
    unzip \
    cmake \
    curl \
    llvm \
    clang \
    clang-tidy \
    cppcheck \
    pkg-config \
    python3-pip \
    libgl1-mesa-dev \
    mesa-common-dev \
    libvulkan-dev \
    libx11-xcb-dev \
    libfontenc-dev \
    libice-dev \
    libsm-dev \
    libxaw7-dev \
    libxcomposite-dev \
    libxcursor-dev \
    libxdamage-dev \
    libxext-dev \
    libxfixes-dev \
    libxi-dev \
    libxinerama-dev \
    libxkbfile-dev \
    libxmu-dev \
    libxmuu-dev \
    libxpm-dev \
    libxrandr-dev \
    libxrender-dev \
    libxres-dev \
    libxss-dev \
    libxt-dev \
    libxtst-dev \
    libxv-dev \
    libxvmc-dev \
    libxxf86vm-dev \
    libxcb-render0-dev \
    libxcb-render-util0-dev \
    libxcb-xkb-dev \
    libxcb-icccm4-dev \
    libxcb-image0-dev \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libxcb-shape0-dev \
    libxcb-sync-dev \
    libxcb-xfixes0-dev \
    libxcb-xinerama0-dev \
    libxcb-dri3-dev \
    libxcb-util-dev \
    libxcb-util0-dev \
    uuid-dev \
    libxcb-cursor-dev && \
    pip3 install conan && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
