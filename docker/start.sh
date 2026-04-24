#!/bin/sh
set -eu

echo "[entry] validating nginx config"
nginx -t

echo "[entry] starting cros server"
node /app/bin/cli.js server /app/server/server.yml &
NODE_PID=$!

cleanup() {
  kill "$NODE_PID" 2>/dev/null || true
}

trap cleanup INT TERM

echo "[entry] starting nginx"
exec nginx -g 'daemon off;'
