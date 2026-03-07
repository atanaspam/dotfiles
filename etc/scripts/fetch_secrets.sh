#!/bin/bash
set -e

read -p "Fetch secrets from Bitwarden? (y/n) " choice
if [[ ! "$choice" =~ ^[yY]$ ]]; then
  echo "Skipping Bitwarden secret fetch. Run fetch_secrets.sh manually when ready."
  exit 0
fi

bw config server https://vault.bitwarden.eu > /dev/null
if ! bw login --check > /dev/null; then
  echo -n "Enter account: "
  read BW_ACCOUNT
  echo -n "Enter password: "
  read -s BW_PASS
  echo
  export BW_SESSION="$(bw login --raw "$BW_ACCOUNT" "$BW_PASS")"
fi
if ! bw unlock --check > /dev/null; then
  echo -n "Enter password: "
  read -s BW_PASS
  echo
  export BW_SESSION="$(bw unlock --raw "$BW_PASS")"
fi

SECRETS_DIR=/tmp/dotfiles_secrets
mkdir -p "$SECRETS_DIR"

trap 'bw logout' EXIT

echo "Fetching GPG public key..."
GPG_ITEM=$(bw get item "GPG")
GPG_ITEM_ID=$(echo "$GPG_ITEM" | jq --raw-output '.id')
PUB_KEY_FILE=$(echo "$GPG_ITEM" | jq --raw-output '.attachments[] | select(.fileName | startswith("gpg")) .fileName')
PUB_KEY_ID=$(echo "$GPG_ITEM" | jq --raw-output '.fields[] | select(.name == "KeyId") | .value')
bw get attachment "$PUB_KEY_FILE" --itemid "$GPG_ITEM_ID" --output "$SECRETS_DIR/gpg_pub.asc"
echo "$PUB_KEY_ID" > "$SECRETS_DIR/gpg_key_id"

echo "Fetching Spotify credentials..."
SPOTIFY_ITEM=$(bw get item "Spotify")
CLIENT_ID=$(echo "$SPOTIFY_ITEM" | jq --raw-output '.fields[] | select(.name == "Client ID") | .value')
CLIENT_SECRET=$(echo "$SPOTIFY_ITEM" | jq --raw-output '.fields[] | select(.name == "Client Secret") | .value')
printf "CLIENT_ID=\"%s\"\nCLIENT_SECRET=\"%s\"\n" "$CLIENT_ID" "$CLIENT_SECRET" > "$SECRETS_DIR/shpotify.cfg"

echo "All secrets fetched."
