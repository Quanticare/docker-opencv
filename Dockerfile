# Image based on Ubuntu 14.04 with all pre-requisites for footprints
#
# Copyright (c) 2015- Quanticare Technologies

# Base image
FROM ubuntu:14.04.2

MAINTAINER Savant Krishna <savant@quanti.care>

ENV DEBIAN_FRONTEND noninteractive

ENV OPENCV_VERSION 3.0.0

RUN apt-get update && apt-get install -y cmake ninja-build wget unzip gcc g++ gstreamer1.0-libav libgstreamer1.0-dev libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-good1.0-dev libgstreamer-plugins-base1.0-dev libpython-dev python-numpy libboost-thread-dev libboost-regex-dev libboost-iostreams-dev libcurl4-openssl-dev gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-tools && \
  #wget --quiet https://github.com/Itseez/opencv/archive/2.4.11.zip && \
  wget --quiet https://github.com/Itseez/opencv/archive/$OPENCV_VERSION.zip && \
  unzip $OPENCV_VERSION.zip && \
  cd opencv-$OPENCV_VERSION/ && \
  mkdir build && cd build && \
  cmake .. -DWITH_FFMPEG=OFF -DWITH_GSTREAMER=ON -DWITH_OPENMP=ON -DBUILD_DOCS=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_EXAMPLES=OFF -DWITH_QT=OFF -DWITH_GTK=OFF -DWITH_OPENGL=OFF -DWITH_VTK=OFF -DWITH_1394=ON -GNinja -DCMAKE_INSTALL_PREFIX=/.opencv-install/ && \
  ninja install && \
  wget --quiet https://github.com/google/glog/archive/v0.3.3.zip && unzip v0.3.3.zip && \
  cd glog-0.3.3/ && ./configure --prefix=/usr && make install -j8 && \
  cd / && rm -rf $OPENCV_VERSION.zip opencv-$OPENCV_VERSION/ glog-0.3.3/ v0.3.3.zip && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

