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

cleanup() {
    if [ -n "$SERVER_PID" ] && kill -0 "$SERVER_PID" > /dev/null 2>&1; then
        kill "$SERVER_PID" > /dev/null 2>&1
    fi
}

trap cleanup EXIT INT TERM

python3 -m http.server 8080 &
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
