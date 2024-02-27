FROM node:lts AS builder

WORKDIR /app

RUN git clone https://github.com/wanghai-king/yacd.git . \
  && npm i -g pnpm \
  && pnpm i \
  && pnpm run build

FROM metacubex/mihomo:latest

COPY files/config.yaml /root/.config/mihomo/
COPY --from=builder /app/public /ui

RUN apk add --no-cache nginx
COPY nginx-default.conf /etc/nginx/http.d/default.conf

RUN nginx && sleep 5 && nginx -s quit
CMD ["nginx", "-g", "daemon off;"]
