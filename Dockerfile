# Start from a base image
FROM metacubex/mihomo:latest

# Combined RUN Commands
RUN mkdir -p /preset-conf /root/.config/clash /ui && \
    apk add --no-cache darkhttpd iptables net-tools curl && \
    wget -P /ui https://github.com/haishanh/yacd/releases/download/v0.3.8/yacd.tar.xz && \
    tar -xJf /ui/yacd.tar.xz -C /ui --strip-components=1 && \
    rm /ui/yacd.tar.xz

# Copy files
COPY files/config.yaml /preset-conf/config.yaml
COPY files/start.sh /start.sh
RUN ls -la /preset-conf && ls -la /

# Modify file permissions
RUN chmod +x /start.sh

# Set the volume, working directory, and exposed ports
VOLUME ["/root/.config/clash"]
WORKDIR /
EXPOSE 7890 7891 9090 80

# Set the start-up script
CMD ["/start.sh"]

# Healthcheck
HEALTHCHECK --interval=600s --timeout=1s CMD ps | grep darkhttpd | grep -v grep || exit 1
