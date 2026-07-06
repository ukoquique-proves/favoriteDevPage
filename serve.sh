#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"
python3 -m http.server 8080 &
SERVER_PID=$!

# Wait until the server is actually accepting connections
for i in {1..10}; do
    if curl -s http://localhost:8080 > /dev/null 2>&1; then
        break
    fi
    sleep 0.5
done

xdg-open http://localhost:8080
wait $SERVER_PID
