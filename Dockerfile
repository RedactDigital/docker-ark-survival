FROM ubuntu:22.04

# Env variables
ENV USER=ark
ENV UID=1000
ENV GID=1000

# Because steam is a 32 bit app, we need to add the i386 architecture
RUN dpkg --add-architecture i386

# Install the required packages
RUN apt update && apt upgrade -y && apt install -y \
    curl \
    wget \
    file \
    tar \
    bzip2 \
    gzip \
    unzip \
    bsdmainutils \
    python3 \
    util-linux \
    ca-certificates \
    binutils \
    bc \
    jq \
    tmux \
    netcat \
    lib32gcc-s1 \
    lib32stdc++6 \
    libsdl2-2.0-0:i386 \
    cpio \
    distro-info \
    xz-utils \
    vim \
    sudo \
    cron \
    iproute2 

# Install NodeJS and GameDig for the web interface
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && npm install -g gamedig

# Install Cleanup
RUN apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Add the ark user and group that will be used to run the server
RUN groupadd --gid ${GID} ${USER} && \
    useradd --create-home --shell /bin/bash --uid ${UID} --gid ${GID} ${USER} && \
    usermod -aG sudo ${USER}

# Ensure sudo group does not require a password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


# Switch to the ark user and download the linuxgsm script
USER ${USER}
WORKDIR /home/${USER}/server

RUN wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh arkserver

# Add LinuxGSM cronjobs
RUN (crontab -l 2>/dev/null; echo "*/5 * * * * /home/${USER}/server/*server monitor > /dev/null 2>&1") | crontab -
RUN (crontab -l 2>/dev/null; echo "*/30 * * * * /home/${USER}/server/*server update > /dev/null 2>&1") | crontab -
RUN (crontab -l 2>/dev/null; echo "0 1 * * 0 /home/${USER}/server/*server update-lgsm > /dev/null 2>&1") | crontab -

COPY --chown=${USER}:${USER} entrypoint.sh /home/${USER}/entrypoint.sh
RUN chmod +x /home/${USER}/entrypoint.sh

ENTRYPOINT ["/home/ark/entrypoint.sh"]