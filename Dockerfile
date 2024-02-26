FROM node:lts AS builder

WORKDIR /app

RUN set -e \
    && git clone https://github.com/haishanh/yacd.git . \
    && npm i \
    && npm run build

# Start from a base image
FROM metacubex/mihomo:latest

COPY files/config.yaml /root/.config/mihomo/
COPY --from=builder /app/dist /ui
