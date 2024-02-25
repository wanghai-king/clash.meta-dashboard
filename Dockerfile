# Use a prebuilt image of mihomo as builder
FROM metacubex/mihomo:latest as builder

# Copy the necessary files and directories
COPY --from=builder /app/dist /ui

# Setup for Clash image
FROM dreamacro/clash:latest
RUN mkdir -p /preset-conf /root/.config/clash \
    && apk add --no-cache darkhttpd iptables net-tools curl vim

# Copy files from the builder image
COPY --from=builder /ui /ui
COPY files/config.yaml /preset-conf/config.yaml
COPY files/start.sh /start.sh

# Modify file permissions for scripts
RUN chmod +x /start.sh

# Download and extract Dashboard
ADD https://github.com/haishanh/yacd/releases/download/v0.3.8/yacd.tar.xz /dashboard
RUN tar -xJf /dashboard/yacd.tar.xz -C /dashboard --strip-components=1 \
    && rm -f /dashboard/yacd.tar.xz

# Set the volume, working directory, and exposed ports
VOLUME ["/root/.config/clash"]
WORKDIR /
EXPOSE 7890 7891 9090 80

# Set the start-up script
CMD ["/start.sh"]
