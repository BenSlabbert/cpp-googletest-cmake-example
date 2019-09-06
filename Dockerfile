FROM ubuntu:bionic

RUN apt-get update --fix-missing && \
    apt-get install -f && \
    apt-get upgrade -y && \
    apt-get install -y build-essential git wget

ARG CMAKE_VERSION=3.15.2

# install cmake
WORKDIR /
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz
RUN tar -xf cmake-${CMAKE_VERSION}.tar.gz
WORKDIR cmake-${CMAKE_VERSION}
RUN ./bootstrap && make && make install
RUN cmake --version

WORKDIR /app
COPY cmd cmd
COPY proxy proxy
COPY CMakeLists.txt CMakeLists.txt
COPY extern/CMakeLists.txt.googletest extern/CMakeLists.txt.googletest
COPY extern/CMakeLists.txt.spdlog extern/CMakeLists.txt.spdlog

RUN cmake .
RUN make
RUN ctest -C Debug -V
RUN make gcov
