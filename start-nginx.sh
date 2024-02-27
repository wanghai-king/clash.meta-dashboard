#!/bin/sh
# start-nginx.sh
# 以守护进程模式关闭启动 nginx
exec nginx -g "daemon off;"
