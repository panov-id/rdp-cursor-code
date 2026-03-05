#!/bin/bash
set -euo pipefail

DESKTOP_USER="${DESKTOP_USER:-user}"
USER_HOME="/home/${DESKTOP_USER}"
VNC_CONFIG_DIR="${USER_HOME}/.config/tigervnc"

# Create VNC config dir
mkdir -p "${VNC_CONFIG_DIR}"

# Set VNC password
echo "${VNC_PASSWORD}" | vncpasswd -f > "${VNC_CONFIG_DIR}/passwd"
chmod 600 "${VNC_CONFIG_DIR}/passwd"
chown -R "${DESKTOP_USER}:${DESKTOP_USER}" "${USER_HOME}/.config"

# Clean stale X locks from previous runs
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

# Start VNC server
su - "${DESKTOP_USER}" -c "vncserver :1 -geometry ${VNC_RESOLUTION} -depth ${VNC_DEPTH} -localhost no"

# Start noVNC (websockify proxy)
websockify --web /usr/share/novnc/ "${NOVNC_PORT}" "localhost:${VNC_PORT}" &

echo "========================================="
echo " noVNC:    http://localhost:${NOVNC_PORT}/vnc.html"
echo " VNC:      localhost:${VNC_PORT}"
echo " User:     ${DESKTOP_USER}"
echo " Password: ${VNC_PASSWORD}"
echo "========================================="

# Keep container running by streaming VNC logs
tail -f "${USER_HOME}"/.config/tigervnc/*.log