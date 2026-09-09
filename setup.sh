#!/usr/bin/env bash
# One-shot Nostr relay install (strfry + Caddy TLS) for Ubuntu/Debian VPS.
# Usage:  sudo bash setup.sh relay.yourdomain.com
set -euo pipefail

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then
  echo "Usage: sudo bash setup.sh relay.yourdomain.com"
  echo "Point that domain's A record at this server's IP first."
  exit 1
fi

# 1) Docker
if ! command -v docker >/dev/null 2>&1; then
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com | sh
fi

# 2) Configure domain
sed -i "s/relay.example.com/$DOMAIN/" Caddyfile
mkdir -p strfry-db

# 3) Launch
docker compose up -d

echo ""
echo "=========================================="
echo " Relay starting at: wss://$DOMAIN"
echo " (TLS cert is issued automatically; give it ~30s)"
echo ""
echo " Test it:   docker logs -f strfry"
echo " Stop it:   docker compose down"
echo " Data dir:  ./strfry-db"
echo "=========================================="
