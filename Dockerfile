# Image based on Ubuntu 14.04 with all pre-requisites for footprints
#
# Copyright (c) 2015- Quanticare Technologies

# Base image
FROM ubuntu:14.04.2

MAINTAINER Savant Krishna <savant@quanti.care>

RUN apt-get install -y wget unzip

RUN wget https://github.com/Itseez/opencv/archive/2.4.11.zip

RUN unzip 2.4.11.zip 

RUN apt-get update && apt-get install -y cmake ninja-build

RUN apt-get install -y gcc g++

RUN apt-get install -y gstreamer1.0-libav libgstreamer1.0-dev libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-good1.0-dev libgstreamer-plugins-base1.0-dev

RUN apt-get install -y libpython-dev python-numpy

RUN cd opencv-2.4.11/ && mkdir build && cd build && cmake .. -DWITH_FFMPEG=OFF -DWITH_GSTREAMER=ON -DWITH_OPENMP=ON -DBUILD_DOCS=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_EXAMPLES=OFF -DWITH_QT=OFF -DWITH_GTK=OFF -DWITH_OPENGL=OFF -DWITH_VTK=OFF -DWITH_1394=OFF -GNinja -DCMAKE_INSTALL_PREFIX=/usr/

ENV DEBIAN_FRONTEND noninteractive

RUN cd opencv-2.4.11/build && ninja install

RUN apt-get install -y libboost-all-dev libcurl4-openssl-dev

RUN wget https://github.com/google/glog/archive/v0.3.4.zip && unzip v0.3.4.zip

RUN cd glog-0.3.4/ && ./configure --prefix=/usr && make install -j8
