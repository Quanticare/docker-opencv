# Image based on Ubuntu 14.04 with all pre-requisites for footprints
#
# Copyright (c) 2015- Quanticare Technologies

# Base image
FROM quay.io/quanticare/cuda
#FROM ubuntu:14.04.2

MAINTAINER Savant Krishna <savant@quanti.care>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y cmake ninja-build wget unzip gcc g++ gstreamer1.0-libav libgstreamer1.0-dev libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-good1.0-dev libgstreamer-plugins-base1.0-dev libpython-dev python-numpy libboost-all-dev libcurl4-openssl-dev gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-tools && \
  wget --quiet https://github.com/Itseez/opencv/archive/2.4.11.zip && \
  unzip 2.4.11.zip && \
  cd opencv-2.4.11/ && \
  mkdir build && cd build && \
  cmake .. -DWITH_CUDA=ON -DCUDA_ARCH_BIN=5.0 -DCUDA_ARCH_PTX=5.0 -DWITH_FFMPEG=OFF -DWITH_GSTREAMER=ON -DWITH_OPENMP=ON -DBUILD_DOCS=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_EXAMPLES=OFF -DWITH_QT=OFF -DWITH_GTK=OFF -DWITH_OPENGL=OFF -DWITH_VTK=OFF -DWITH_1394=ON -GNinja -DCMAKE_INSTALL_PREFIX=/usr/ && \
  ninja install && \
  wget --quiet https://github.com/google/glog/archive/v0.3.3.zip && unzip v0.3.3.zip && \
  cd glog-0.3.3/ && ./configure --prefix=/usr && make install -j8 && \
  cd / && rm -rf 2.4.11.zip opencv-2.4.11/ glog-0.3.3/ v0.3.3.zip && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


