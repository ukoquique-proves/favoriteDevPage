#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

# Build the site first
echo "Building the site..."
bash build.sh
if [ $? -ne 0 ]; then
    echo "Build failed. Aborting server start."
    exit 1
fi

# Kill any existing process on port 8080
echo "Checking for existing process on port 8080..."

# First try killing our specific server command (most reliable)
pkill -9 -f "python3 -m http.server 8080" 2>/dev/null
sleep 1

# Then use port-based methods as backup
# Use fuser (most reliable if available)
if command -v fuser > /dev/null 2>&1; then
    FUSER_PIDS=$(fuser 8080/tcp 2>/dev/null)
    if [ -n "$FUSER_PIDS" ]; then
        echo "Killing existing process(es) on port 8080: $FUSER_PIDS"
        kill -9 $FUSER_PIDS 2>/dev/null
        sleep 1
    fi
# Fallback to lsof, properly parsing just PIDs
elif command -v lsof > /dev/null 2>&1; then
    LSOF_PIDS=$(lsof -t -i :8080 -s TCP:LISTEN 2>/dev/null | xargs)
    if [ -n "$LSOF_PIDS" ]; then
        echo "Killing existing process(es) on port 8080: $LSOF_PIDS"
        kill -9 $LSOF_PIDS 2>/dev/null
        sleep 1
    fi
# Fallback to ss
elif command -v ss > /dev/null 2>&1; then
    SS_PIDS=$(ss -Htulpn 2>/dev/null | grep :8080 | awk '{print $7}' | sed -E 's/.*pid=([0-9]+).*/\1/' | xargs)
    if [ -n "$SS_PIDS" ]; then
        echo "Killing existing process(es) on port 8080: $SS_PIDS"
        kill -9 $SS_PIDS 2>/dev/null
        sleep 1
    fi
# Fallback to netstat
elif command -v netstat > /dev/null 2>&1; then
    NETSTAT_PIDS=$(netstat -tulpn 2>/dev/null | grep :8080 | awk '{print $7}' | cut -d'/' -f1 | xargs)
    if [ -n "$NETSTAT_PIDS" ]; then
        echo "Killing existing process(es) on port 8080: $NETSTAT_PIDS"
        kill -9 $NETSTAT_PIDS 2>/dev/null
        sleep 1
    fi
fi

cleanup() {
    if [ -n "$SERVER_PID" ] && kill -0 "$SERVER_PID" > /dev/null 2>&1; then
        kill "$SERVER_PID" > /dev/null 2>&1
    fi
}

trap cleanup EXIT INT TERM

# Use a small Python script to enable SO_REUSEADDR/SO_REUSEPORT for quick restart
python3 -c "
import socketserver
import http.server
import os

PORT = 8080

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Expires', '0')
        super().end_headers()

# Enable address reuse
socketserver.TCPServer.allow_reuse_address = True
socketserver.TCPServer.allow_reuse_port = True

with socketserver.TCPServer(('', PORT), MyHTTPRequestHandler) as httpd:
    print(f'Serving HTTP on 0.0.0.0 port {PORT} (http://0.0.0.0:{PORT}/) ...')
    httpd.serve_forever()
" &
SERVER_PID=$!

# Wait until the server is actually accepting connections
for i in {1..10}; do
    if curl -s http://localhost:8080 > /dev/null 2>&1; then
        break
    fi
    sleep 0.5
done

if command -v xdg-open > /dev/null 2>&1 && { [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; }; then
    xdg-open http://localhost:8080 > /dev/null 2>&1 &
else
    echo "Server running at http://localhost:8080"
    echo "Browser not opened automatically (headless session or xdg-open unavailable)."
fi

wait $SERVER_PID
