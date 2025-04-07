# Dockerfile for building general development
# environment for machine learning network activities
FROM ubuntu:24.04
LABEL maintainer "michaelchan_wahyan@yahoo.com.hk"

ENV SHELL=/bin/bash \
    PYTHONIOENCODING=UTF-8 \
    PATH=/usr/local/bin:/bin:/usr/bin:/lib:/lib64:/lib32:/libx32:/usr/lib:/usr/local/lib:/sbin:/usr/sbin:/usr/local/sbin

RUN apt-get -y update

RUN apt-get -y install \
        apt-transport-https \
        apt-utils \
        bc \
        build-essential \
        curl \
        gcc \
        git \
        htop \
        libbz2-dev \
        libc6-dev \
        libcurl4-openssl-dev \
        libffi-dev \
        libfontconfig1-dev \
        libgdbm-dev \
        liblzma-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        llvm \
        make \
        net-tools \
        openssl \
        screen \
        sqlite3 \
        tk-dev \
        vim \
        wget \
        xz-utils \
        zlib1g-dev

## ----------------------------------------------------------------------------
## build Python 3.11.9
## ----------------------------------------------------------------------------
## option --disable-test-modules : Install Options
## option --without-doc-strings  : Performance Options
## option --enable-optimizations
RUN cd / ;\
    wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz ;\
    tar -zxvf Python-3.11.9.tgz

RUN cd /Python-3.11.9 ;\
    ./configure \
        --disable-test-modules \
        --without-doc-strings \
        --enable-loadable-sqlite-extensions \
        --enable-optimizations

RUN cd /Python-3.11.9 ;\
    make -j1 ;\
    make install

## ----------------------------------------------------------------------------
## upgrade pip and install wheel
## ----------------------------------------------------------------------------
RUN python3 -m pip install --upgrade pip setuptools wheel

RUN pip3 install \
    numpy==2.1.3 \
    scikit-learn==1.6.1 \
    pillow==11.1.0 \
    pandas==2.2.3

## ----------------------------------------------------------------------------
## For CPU-only tensorflow
## ----------------------------------------------------------------------------
#
# TensorFlow version compatibility matrix
# source: https://www.tensorflow.org/install/source#tested_build_configurations
#
# Tested build configurations
# Linux [CPU]
# TF_Version Python_version Compiler        Build_tools
# 2.18.0     3.9-3.12       Clang 17.0.6    Bazel 6.5.0
# 2.17.0     3.9-3.12       Clang 17.0.6    Bazel 6.5.0
# 2.16.1     3.9-3.12       Clang 17.0.6    Bazel 6.5.0
# 2.15.0     3.9-3.11       Clang 16.0.0    Bazel 6.1.0
# 2.14.0     3.9-3.11       Clang 16.0.0    Bazel 6.1.0
# 2.13.0     3.8-3.11       Clang 16.0.0    Bazel 5.3.0
# 2.12.0     3.8-3.11       GCC 9.3.1       Bazel 5.3.0
# 2.11.0     3.7-3.10       GCC 9.3.1       Bazel 5.3.0
# 2.10.0     3.7-3.10       GCC 9.3.1       Bazel 5.1.1
# 2.9.0      3.7-3.10       GCC 9.3.1       Bazel 5.0.0
# 2.8.0      3.7-3.10       GCC 7.3.1       Bazel 4.2.1
# 2.7.0      3.7-3.9        GCC 7.3.1       Bazel 3.7.2
# 2.6.0      3.6-3.9        GCC 7.3.1       Bazel 3.7.2
# 2.5.0      3.6-3.9        GCC 7.3.1       Bazel 3.7.2
# 2.4.0      3.6-3.8        GCC 7.3.1       Bazel 3.1.0
# 2.3.0      3.5-3.8        GCC 7.3.1       Bazel 3.1.0
# 2.2.0      3.5-3.8        GCC 7.3.1       Bazel 2.0.0

RUN pip3 install tensorflow==2.15.0

COPY [".bashrc", ".vimrc", "/root/"]
EXPOSE 6006
CMD [ "/bin/bash" ]
