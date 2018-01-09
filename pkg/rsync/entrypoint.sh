#!/bin/sh
VOLUME=${VOLUME:-/volume}
VOLUMES=${VOLUMES:-$VOLUME}
ALLOW=${ALLOW:-192.168.0.0/16 172.16.0.0/12}
USER=${USER:-nobody}
GROUP=${GROUP:-nogroup}
CONF_FILE=${CONF_FILE:-"/tmp/rsyncd.conf"}

mkdir -p ${VOLUME}

getent group ${GROUP} > /dev/null || addgroup ${GROUP}
getent passwd ${USER} > /dev/null || adduser -D -H -G ${GROUP} ${USER}
chown -R ${USER}:${GROUP} ${VOLUME}

cat <<EOF > ${CONF_FILE}
uid = ${USER}
gid = ${GROUP}
use chroot = yes
log file = /dev/stdout
reverse lookup = no
EOF

for volume in $VOLUMES; do
cat <<EOF >> ${CONF_FILE}
[${volume}]
    hosts deny = *
    hosts allow = ${ALLOW}
    read only = false
    path = ${volume}
    comment = container mount ${volume}
EOF
done

exec /usr/bin/rsync --no-detach --daemon --config ${CONF_FILE}