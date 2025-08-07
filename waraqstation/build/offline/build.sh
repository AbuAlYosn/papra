#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
IMAGES_DIR="$ROOT_DIR/images"

mkdir -p "$IMAGES_DIR"

# Build custom Paperless with Arabic OCR
( cd "$ROOT_DIR/paperless" && docker build -t waraqstation/paperless-ngx:ara . )

# Pull dependencies at pinned tags
docker pull redis:7-alpine
docker pull postgres:16-alpine
docker pull gotenberg/gotenberg:8
docker pull ghcr.io/paperless-ngx/tika:latest
docker pull nginx:alpine

# Save images to tar (for Windows offline loading)
docker save -o "$IMAGES_DIR/waraqstation-paperless-ngx-ara.tar" waraqstation/paperless-ngx:ara
docker save -o "$IMAGES_DIR/redis-7-alpine.tar" redis:7-alpine
docker save -o "$IMAGES_DIR/postgres-16-alpine.tar" postgres:16-alpine
docker save -o "$IMAGES_DIR/gotenberg-8.tar" gotenberg/gotenberg:8
docker save -o "$IMAGES_DIR/tika-latest.tar" ghcr.io/paperless-ngx/tika:latest
docker save -o "$IMAGES_DIR/nginx-alpine.tar" nginx:alpine

echo "Offline image bundle written to: $IMAGES_DIR"