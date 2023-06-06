#!/bin/bash

# Constants
USER=ark
WORKDIR=/home/${USER}/server

# Environment variables (set in docker-compose.yml)
MAP=${MAP:-"TheIsland"}
PORT=${PORT:-"7777"}
QUERYPORT=${QUERYPORT:-"27015"}
RCONPORT=${RCONPORT:-"27020"}
EVENT=${EVENT:-"None"}
CLUSTER=${CLUSTER:-"cluster"}
OPTIONS=${OPTIONS:-""}
MULTIHOME=${MULTIHOME:-""}

exit_handler() {
    # Execute the  shutdown commands
    echo "recieved SIGTERM stopping ${MAP}"
    ./${MAP} stop
    exit 0
}

# Trap SIGTERM and call the shutdown handler
echo "---"
echo "Loading exit handler"
trap exit_handler SIGTERM

# Make sure user owns the server files
echo "---"
echo "Setting ownership of ${WORKDIR} to ${USER}"
sudo chown -R ${USER}:${USER} ${WORKDIR}

# Install the ark server
echo "---"
if [ -z "$(ls -A -- "${WORKDIR}/serverfiles")" ]; then
    echo "installing ${MAP}"
    ./arkserver auto-install
else
    echo "serverfiles already installed"
fi

# Make sure user owns the server files
echo "---"
echo "Setting ownership of ${WORKDIR} to ${USER}"
sudo chown -R ${USER}:${USER} ${WORKDIR}

# Update the server
echo "---"
echo "Updating ${MAP}"
${WORKDIR}/arkserver update

# Configure lgsm config
echo "---"
echo "Configuring ${MAP} startup config"
rm -f ${WORKDIR}/lgsm/config-lgsm/arkserver/arkserver.cfg
echo "
####### Instance Settings ########
##################################
# PLACE INSTANCE SETTINGS HERE
## These settings will apply to a specific instance.
#### Server Settings ####

fn_parms() {
    parms=\"\\\"${MAP}?AltSaveDirectoryName=${MAP}?listen?QueryPort=${QUERYPORT}?RCONPort=${RCONPORT}?Port=${PORT}?MultiHome=${MULTIHOME} -ActiveEvent=${EVENT} ${OPTIONS} -clusterid=${CLUSTER} \\\"\"
}
" >${WORKDIR}/lgsm/config-lgsm/arkserver/arkserver.cfg

# Start Cron
echo "---"
echo "Starting cron"
sudo cron

# Start the server
echo "---"
echo "Starting ${MAP}"
${WORKDIR}/arkserver start
sleep 5
${WORKDIR}/arkserver details

tail -f ${WORKDIR}/log/console/arkserver-console.log

# with no command, just spawn a running container suitable for exec's
if [ $# = 0 ]; then
    tail -f /dev/null
else
    # execute the command passed through docker
    "$@"

    # if this command was a server start cmd
    # to get around LinuxGSM running everything in
    # tmux;
    # we attempt to attach to tmux to track the server
    # this keeps the container running
    # when invoked via docker run
    # but requires -it or at least -t
    tmux set -g status off && tmux attach 2>/dev/null
fi

exec "$@"
