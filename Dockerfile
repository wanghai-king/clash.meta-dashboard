FROM node:lts AS builder

WORKDIR /app

# 克隆仓库并安装依赖
RUN git clone https://github.com/wanghai-king/yacd.git . \
    && npm install -g pnpm \
    && pnpm install \
    && pnpm run build

# 设置运行时容器
FROM metacubex/mihomo:latest

# 复制配置文件
COPY files/config.yaml /root/.config/mihomo/
COPY --from=builder /app/public /ui

# 安装nginx及brotli模块
RUN apk add --no-cache nginx \
    nginx-mod-http-brotli \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

# 复制Nginx配置文件
COPY nginx-default.conf /etc/nginx/http.d/default.conf

# 暴露Nginx运行时监听的端口
EXPOSE 80

# 强制删除默认的Nginx配置文件（如果存在）
RUN rm -f /etc/nginx/conf.d/default.conf

# 以前台模式启动Nginx
CMD ["nginx", "-g", "daemon off;"]
