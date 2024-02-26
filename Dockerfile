FROM node:lts AS builder

WORKDIR /app

RUN set -e \
    && git clone https://github.com/haishanh/yacd.git . \
    && npm i \
    && npm run build
