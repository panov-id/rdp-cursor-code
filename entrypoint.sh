#!/bin/bash
set -e

USER_NAME=$(ls /home/ | head -1)
USER_HOME="/home/${USER_NAME}"
VNC_DIR="${USER_HOME}/.config/tigervnc"

# Create config dir
mkdir -p ${VNC_DIR}

# Set VNC password
echo "$VNC_PASSWORD" | vncpasswd -f > ${VNC_DIR}/passwd
chmod 600 ${VNC_DIR}/passwd
chown -R ${USER_NAME}:${USER_NAME} ${USER_HOME}/.config

# Clean stale locks
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

# Start VNC server
su - ${USER_NAME} -c "vncserver :1 -geometry ${VNC_RESOLUTION} -depth ${VNC_DEPTH} -localhost no"

# Start noVNC
websockify --web /usr/share/novnc/ ${NOVNC_PORT} localhost:${VNC_PORT} &

echo "========================================="
echo " noVNC:    http://localhost:${NOVNC_PORT}/vnc.html"
echo " VNC:      localhost:${VNC_PORT}"
echo " User:     ${USER_NAME}"
echo " Password: ${VNC_PASSWORD}"
echo "========================================="

tail -f ${USER_HOME}/.config/tigervnc/*.log