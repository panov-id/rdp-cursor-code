## Overview

This project provides:

- **`debian-xfce-cursor`**: a Debian 13 XFCE desktop accessible over RDP with Cursor installed.
- **`php-launchpad`**: a PHP 8.4 + Composer container for running PHP code and tests against your mounted project.

## Prerequisites

- Docker and Docker Compose v2
- An RDP client (e.g. `xfreerdp`, Remmina, Windows Remote Desktop)

## Configuration

All configuration is in `.env`:

- **`RDP_USER` / `RDP_PASS`**: credentials for RDP login.
- **`RDP_PORT`**: host port mapped to container port 3389 (default: `33309`).
- **`HOST_PROJECTS_DIR`**: path to your projects on the host.
- **`CONTAINER_PROJECTS_DIR`**: path where projects are mounted inside the RDP container (default: `/home/user/projects`).

## Start the RDP desktop container

From the project root:

```bash
docker compose up -d debian-xfce-cursor
```

Then connect with your RDP client to:

- **Host**: `localhost`
- **Port**: value of `RDP_PORT` in `.env` (e.g. `33309`)
- **User**: `RDP_USER`
- **Password**: `RDP_PASS`

To stop the desktop:

```bash
docker compose down
```

## PHP container (`php-launchpad`)

The `php-launchpad` service is used to run PHP commands and tests in an isolated container with PHP 8.4 and Composer.

### Build the PHP image

```bash
docker compose build php-launchpad
```

### Run PHP commands

Run a one-off PHP command:

```bash
docker compose run --rm php-launchpad php -v
```

Run a specific PHP script inside the project:

```bash
docker compose run --rm php-launchpad php path/to/script.php
```

### Use Composer

Install dependencies:

```bash
docker compose run --rm php-launchpad composer install
```

Require a new package (example: PHPUnit):

```bash
docker compose run --rm php-launchpad composer require phpunit/phpunit --dev
```

### Run tests (example with PHPUnit)

Assuming you have PHPUnit installed in `vendor/bin`:

```bash
docker compose run --rm php-launchpad php vendor/bin/phpunit
```

### Interactive shell in the PHP container

```bash
docker compose run --rm php-launchpad bash
```

Inside the container you can run `php`, `composer`, and any test commands directly.

