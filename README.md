## Overview

This project provides a **Debian 13 XFCE desktop** with **Cursor** installed, accessible via **VNC / noVNC**.

The main service defined in `docker-compose.yml` is **`novnc-cursor`**.

## Prerequisites

- Docker and Docker Compose v2
- Any modern browser (for noVNC) and/or a VNC client

## Configuration

All configuration is defined in the `.env` file:

- **`DESKTOP_USER` / `DESKTOP_PASSWORD`**: Linux user and password inside the container (XFCE with Cursor).
- **`VNC_PASSWORD`**: password for the VNC / noVNC session.
- **`VNC_RESOLUTION`**: desktop resolution, for example `2560x1440`.
- **`VNC_DEPTH`**: color depth, for example `24`.
- **`VNC_PORT`**: VNC port inside the container (default: `5901`).
- **`NOVNC_PORT`**: port exposed on the host for noVNC (default: `6080`).
- **`LANG`**: locale (for example `en_US.UTF-8`).
- **`TZ`**: time zone (for example `Europe/Nicosia`).
- **`HOST_PROJECTS_DIR`**: path to your projects on the host machine.
- **`CONTAINER_PROJECTS_DIR`**: path where these projects will be available inside the container (typically something like `/home/<DESKTOP_USER>/projects`).

Before starting:

1. Copy `.env.example` to `.env`.
2. Adjust the values to match your environment.

### Security note

Always change the default passwords (`VNC_PASSWORD`, `DESKTOP_PASSWORD`) in your local `.env`. Do not use the example values in any shared or production environment.

### Example paths

```text
HOST_PROJECTS_DIR=/home/youruser/projects
CONTAINER_PROJECTS_DIR=/home/youruser/projects
```

## Start the desktop container

From the project root:

```bash
docker compose up -d novnc-cursor
```

Docker will build the image from `Dockerfile-novnc-cursor` and start an XFCE desktop with VNC and noVNC.

### Keyboard layout

The desktop is configured with US and RU layouts. You can switch between them using `Alt+Shift`.

### Connect via browser (noVNC)

Open in your browser:

- `http://localhost:<NOVNC_PORT>/vnc.html`

where `<NOVNC_PORT>` is the value from `.env` (default: `6080`).

When prompted:

- **Password**: the value of `VNC_PASSWORD` from `.env`.

### Connect via VNC client

In your VNC client specify:

- **Host**: `localhost`
- **Port**: value of `VNC_PORT` from `.env` (default: `5901`)
- **Password**: `VNC_PASSWORD`

After connecting you will see the XFCE desktop with Cursor installed and will be able to work with projects mounted from `HOST_PROJECTS_DIR`.

## Stop the desktop

To stop the container:

```bash
docker compose down
```
