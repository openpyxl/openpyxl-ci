FROM ubuntu:14.04

MAINTAINER Eric Gazoni <eric.gazoni@adimian.com>

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV PYTHONIOENCODING=utf8

RUN apt-get update && apt-get upgrade -y

RUN locale-gen en_US.UTF-8 \
    && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales


RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    software-properties-common \
    python-software-properties \
    libjpeg-dev \
    g++

RUN add-apt-repository -y ppa:fkrull/deadsnakes \
    && apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    libxml2-dev libxslt1-dev \
    python2.6 python2.6-dev \
    python2.7 python2.7-dev \
    python3.2 python3.2-dev \
    python3.3 python3.3-dev \
    python3.4 python3.4-dev \
    python3.5 python3.5-dev

ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py

RUN python /tmp/get-pip.py
RUN pip install tox

ADD clean-launch.sh /tools/clean-launch.sh
ADD build-coverage.sh /tools/build-coverage.sh

ADD passwd.minimal /etc/passwd.ext
RUN cat /etc/passwd.ext >> /etc/passwd
USER me

VOLUME /source
WORKDIR /source

ENTRYPOINT ["/tools/clean-launch.sh"]
CMD ["tox"] 
