# base image
FROM python:3.9-slim

# to look cool
ENV DEBIAN_FRONTEND=noninteractive _EDOC="https://gitlab.com/loverboyXD/AstroUB/-/archive/main/AstroUB-main.zip"

# base directory
RUN mkdir app
WORKDIR /app/

# upstream
RUN apt update && apt upgrade -y

# apt dependencies
RUN apt install --no-install-recommends -y \
    git bash ffmpeg mediainfo gcc wget \
    python3-dev procps neofetch make curl \
    zip unzip jq pv linux-headers-amd64 \
    python3-lxml postgresql musl musl-dev \
    postgresql-client

# update pip and install requirements
COPY reqs.txt run ./
RUN pip3 install -U pip \
    && pip3 install --no-cache-dir -r reqs.txt

# cleanup, if needed
RUN apt autoremove --purge 

# initialise app
CMD [ "bash", "run" ]
