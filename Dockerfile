FROM debian:stable

###
# install dependencies
RUN apt update
RUN apt install --no-install-recommends --assume-yes \
    locales \
    gettext \
    man-db \
    psmisc \
    procps \
    nano \
    tree \
    ncal \
    x11-apps \
    python3 \
    python-is-python3
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

###
# install locales and set default
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
RUN sed -i 's/^# *\(fr_FR.UTF-8\)/\1/' /etc/locale.gen
RUN sed -i 's/^# *\(it_IT.UTF-8\)/\1/' /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

###
# set user and group
ARG user=gsh-user
ARG group=gsh-user
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -s /bin/sh -m ${user} # <--- the '-m' create a user home directory

###
# switch to user
USER ${uid}:${gid}
WORKDIR /home/${user}


### use the latest github version
ADD --chown=gsh-user:gsh-user https://github.com/phyver/GameShell/releases/download/latest/gameshell.sh gameshell.sh

### if you prefer to use a local customized version, comment the preceeding
### ADD ...
### line and uncomment the next one
### (NOTE that you need to have generated a "gameshell.sh" file with GSH_ROOT/utils/gameshell_archive.sh
# COPY gameshell.sh .

### entrypoint wrapper -- conditionally hides python (GSH_ENABLE_PYTHON=0,
### set per-session by deploy/gsh-session.sh) before handing off to the game
COPY --chown=gsh-user:gsh-user deploy/docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
