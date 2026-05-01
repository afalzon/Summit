#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOST_UID="$(id -u)"
HOST_GID="$(id -g)"

# Build and package Firefox extension artifacts in a clean Node 24 container.
docker run --rm \
  -e HOST_UID="$HOST_UID" \
  -e HOST_GID="$HOST_GID" \
  -v "$REPO_DIR":/app \
  -w /app \
  node:24 \
  bash -lc "rm -rf node_modules && npm ci && npm run package:firefox && rm -rf node_modules && chown -R \"$HOST_UID:$HOST_GID\" dist artifacts"

echo "Firefox artifact ready: $REPO_DIR/artifacts/Summit-firefox.zip"
echo "Load temporary add-on from: $REPO_DIR/dist/manifest.json"
