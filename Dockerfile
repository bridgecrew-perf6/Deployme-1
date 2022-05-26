# base image
FROM python:3.9-slim

# non interactive 
ENV DEBIAN_FRONTEND=noninteractive _EDOC="https://gitlab.com/loverboyXD/AstroUB/-/archive/main/AstroUB-main.zip"

# base directory
RUN mkdir myapp
WORKDIR /myapp

# upstream
RUN apt update && apt upgrade -y \
    && apt install -y apt-utils gcc

# apt dependencies
RUN apt install --no-install-recommends -y \
    git bash ffmpeg mediainfo wget curl python3-dev \
    procps neofetch zip unzip linux-headers-amd64 \
    make pv jq libel1 python3-lxml postgresql musl musl-dev \
    postgresql-client

# cleanup, if needed
RUN apt autoremove -y --purge

# update pip and install requirements
COPY reqs.txt run ./
RUN pip3 install -U pip \
    && pip3 install -r reqs.txt && rm reqs.txt

# initialise app
CMD [ "bash", "run" ]
