FROM nvcr.io/nvidia/cuda:10.2-cudnn8-devel-ubuntu18.04
LABEL maintainer="Learning@home"
LABEL repository="hivemind"

WORKDIR /home
# Set en_US.UTF-8 locale by default
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment

# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends --force-yes \
  build-essential \
  curl \
  wget \
  git \
  vim \
  python3.8 \
  python3-pip \
  python3-setuptools \
  && apt-get clean autoclean && rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

RUN python3.8 -m pip install --upgrade pip 
RUN python3.8 -m pip install --ignore-installed setuptools 

RUN echo `python3.8 -m pip --version`

COPY . hivemind/

RUN python3.8 -m pip install --default-timeout=10000 --no-cache-dir -r hivemind/requirements.txt 
RUN python3.8 -m pip install --no-cache-dir -r hivemind/requirements-dev.txt
RUN python3.8 -m pip install --no-cache-dir -r hivemind/examples/albert/requirements.txt 
RUN rm -rf ~/.cache/pip

RUN cd hivemind && \
    python3.8 -m pip install --no-cache-dir .[dev] && \
    rm -rf ~/.cache/pip

