#!/bin/sh
echo "Starting Nginx..."
nginx -g 'daemon off;' || echo "Failed to start Nginx"
