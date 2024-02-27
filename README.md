# Mihomo, with Dashboard

## Quick Start

```shell
docker run -d --restart always --name mihomo-dashboard \
-p 5700:80 -p 9090:9090 -p 7890:7890 -p 7891:7891 \
-v $(pwd)/config:/root/.config/mihomo \
qwezxcjkl/mihomo-dashboard:latest
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
