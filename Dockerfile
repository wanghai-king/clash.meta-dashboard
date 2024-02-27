FROM node:lts AS builder

WORKDIR /app

RUN git clone https://github.com/haishanh/yacd.git . 
RUN npm i -g pnpm
RUN pnpm i 
RUN pnpm run build
RUN ls -la /app/public

FROM metacubex/mihomo:latest

COPY files/config.yaml /root/.config/mihomo/
COPY --from=builder /app/public /ui
