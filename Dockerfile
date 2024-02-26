FROM node:lts AS builder

WORKDIR /app

RUN git clone https://github.com/haishanh/yacd.git . 
RUN npm i -g pnpm
RUN pnpm i 
RUN pnpm run build
RUN ls -la /app/public

FROM metacubex/mihomo:latest

# 安装Nginx
RUN apk update && apk add nginx brotli

# 复制你的文件和配置
COPY files/config.yaml /root/.config/mihomo/
COPY --from=builder /app/public /ui  

# 复制你的Nginx配置文件到默认位置
COPY nginx-default.conf /etc/nginx/nginx.conf

# 启动Nginx
CMD ["nginx", "-g", "daemon off;"]
