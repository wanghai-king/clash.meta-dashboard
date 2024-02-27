#!/bin/sh
# 启动 Nginx
nginx -g 'daemon off;' &

# 假设 Nginx 成功启动，现在启动 mihomo
exec /mihomo
