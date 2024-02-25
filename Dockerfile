# Step 1 - Build process
FROM node:latest as builder
WORKDIR /app
RUN git clone https://github.com/MetaCubeX/mihomo.git .
RUN yarn && yarn run build

# Step 2 - Setup our Clash image
FROM dreamacro/clash:latest
RUN mkdir -p /preset-conf /root/.config/clash \
    && apk add --no-cache darkhttpd iptables net-tools curl vim
COPY --from=builder /app/dist /ui
COPY files/config.yaml /preset-conf/config.yaml
COPY files/start.sh /start.sh
RUN chmod +x /start.sh

# Download and extract Dashboard
ADD https://github.com/haishanh/yacd/releases/download/v0.3.8/yacd.tar.xz /dashboard
RUN tar -xJf /dashboard/yacd.tar.xz -C /dashboard --strip-components=1 \
    && rm -f /dashboard/yacd.tar.xz

VOLUME ["/root/.config/clash"]
WORKDIR /
EXPOSE 7890 7891 9090 80
CMD ["/start.sh"]
