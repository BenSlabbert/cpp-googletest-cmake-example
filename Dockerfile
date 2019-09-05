FROM ubuntu:bionic

RUN apt update -qq --fix-missing && apt install -f && apt upgrade -y && apt install -y build-essential git wget

ARG CMAKE_VERSION=3.15.2

# install cmake
WORKDIR /
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz
RUN tar -xf cmake-${CMAKE_VERSION}.tar.gz
WORKDIR cmake-${CMAKE_VERSION}
RUN ./bootstrap && make && make install
RUN cmake --version

WORKDIR /app
COPY src src
COPY CMakeLists.txt CMakeLists.txt

RUN ls -alh
RUN cmake .
RUN make
