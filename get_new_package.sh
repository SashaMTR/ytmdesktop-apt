#!/usr/bin/env bash
set -euo pipefail

REPO="ytmdesktop/ytmdesktop"
POOL="debian/pool"

echo "Fetching latest release info from GitHub..."
RELEASE_JSON=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest")

VERSION=$(echo "$RELEASE_JSON" | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"v\?\([^"]*\)".*/\1/')
DEB_URL=$(echo "$RELEASE_JSON" | grep '"browser_download_url"' | grep '_amd64.deb"' | head -1 | sed 's/.*"browser_download_url": *"\([^"]*\)".*/\1/')

if [ -z "$DEB_URL" ]; then
  echo "No amd64 .deb found in latest release."
  exit 1
fi

DEB_FILE="${POOL}/$(basename "$DEB_URL")"

if [ -f "$DEB_FILE" ]; then
  echo "Already have $(basename "$DEB_URL"), nothing to do."
  exit 0
fi

echo "New version: $VERSION"
echo "Downloading: $DEB_URL"
mkdir -p "$POOL"

# Remove old debs
rm -f "${POOL}"/*.deb

wget -q --show-progress -O "$DEB_FILE" "$DEB_URL"
echo "Downloaded: $DEB_FILE"
