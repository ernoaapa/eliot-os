#!/bin/sh
VOLUME=${VOLUME:-/volume}
ALLOW=${ALLOW:-192.168.0.0/16 172.16.0.0/12}
USER=${USER:-nobody}
GROUP=${GROUP:-nogroup}

mkdir -p ${VOLUME}

getent group ${GROUP} > /dev/null || addgroup ${GROUP}
getent passwd ${USER} > /dev/null || adduser -D -H -G ${GROUP} ${USER}
chown -R ${USER}:${GROUP} ${VOLUME}

cat <<EOF > /etc/rsyncd.conf
uid = ${USER}
gid = ${GROUP}
use chroot = yes
log file = /dev/stdout
reverse lookup = no
[volume]
    hosts deny = *
    hosts allow = ${ALLOW}
    read only = false
    path = ${VOLUME}
    comment = docker volume
EOF

exec /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf