#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOST_UID="$(id -u)"
HOST_GID="$(id -g)"

# Build and package Chromium extension artifacts in a clean Node 24 container.
docker run --rm \
  -e HOST_UID="$HOST_UID" \
  -e HOST_GID="$HOST_GID" \
  -v "$REPO_DIR":/app \
  -w /app \
  node:24 \
  bash -lc "rm -rf node_modules && npm ci && npm run package:chromium && rm -rf node_modules && chown -R \"$HOST_UID:$HOST_GID\" dist artifacts"

echo "Chromium artifact ready: $REPO_DIR/artifacts/Summit-chromium.zip"
echo "Load unpacked extension from: $REPO_DIR/dist"
