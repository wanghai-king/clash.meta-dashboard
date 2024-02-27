# Mihomo, with Dashboard

[![Docker Build Status](https://img.shields.io/docker/build/zyao89/clash-with-dashboard.svg)](https://hub.docker.com/r/zyao89/clash-with-dashboard) [![Docker Automated build](https://img.shields.io/docker/automated/zyao89/clash-with-dashboard.svg)](https://hub.docker.com/r/zyao89/clash-with-dashboard) [![Docker Stars](https://img.shields.io/docker/stars/zyao89/clash-with-dashboard.svg)](https://hub.docker.com/r/zyao89/clash-with-dashboard) [![Docker Pulls](https://img.shields.io/docker/pulls/zyao89/clash-with-dashboard.svg)](https://hub.docker.com/r/zyao89/clash-with-dashboard)

This Dockerfile build an image for [clash](https://github.com/dreamacro/clash) with [clash-dashboard](https://github.com/dreamacro/clash-dashboard) frontends.

## Quick Start

```shell
docker run -d --name clash-dashboard \
-p 80:80 -p 7890:7890 -p 7891:7891 \
-v ./config.yaml:/root/.config/clash/config.yaml \
zyao89/clash-with-dashboard
```

## Docker Compose

```yaml
version: '3.8'

services:
  meta:
    container_name: mihomo-dashboard
    image: qwezxcjkl/mihomo-dashboard:latest
    restart: always
    ports:
      - "5700:80"
      - "9090:9090"
      - "7890:7890"
      - "7891:7891"
    volumes:
      - ./config:/root/.config/mihomo
```

## Thanks

This docker image is based on [dreamacro](https://hub.docker.com/r/dreamacro/clash/)'s docker image.
