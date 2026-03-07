#!/usr/bin/env bash
set -e

SECRETS_DIR=/tmp/dotfiles_secrets
if [ ! -f "$SECRETS_DIR/shpotify.cfg" ]; then
  echo "WARNING: Spotify credentials not found. Skipping. Run fetch_secrets.sh manually when ready."
  exit 0
fi

mv "$SECRETS_DIR/shpotify.cfg" ~/.shpotify.cfg
chmod 600 ~/.shpotify.cfg
echo "Spotify credentials installed at ~/.shpotify.cfg"
