#!/bin/sh
set -eu

node /app/bin/cli.js server /app/server/server.yml &
NODE_PID=$!

cleanup() {
  kill "$NODE_PID" 2>/dev/null || true
}

trap cleanup INT TERM

exec nginx -g 'daemon off;'
