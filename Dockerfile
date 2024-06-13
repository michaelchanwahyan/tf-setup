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

RUN cd Python-3.11.9 ;\
    ./configure \
        --disable-test-modules \
        --without-doc-strings \
        --enable-loadable-sqlite-extensions \
        --enable-optimizations ;\
    make -j1 ;\
    make install

## ----------------------------------------------------------------------------
## upgrade pip and install wheel
## ----------------------------------------------------------------------------
RUN python3 -m pip install --upgrade pip setuptools wheel

## ----------------------------------------------------------------------------
## For CPU-only tensorflow
## ----------------------------------------------------------------------------
RUN pip install tensorflow

CMD [ "/bin/bash" ]
