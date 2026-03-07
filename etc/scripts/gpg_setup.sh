#!/bin/bash
set -e

echo "Configuring GNUPG"
chown -R $(whoami) ~/.gnupg/

SECRETS_DIR=/tmp/dotfiles_secrets
if [ ! -f "$SECRETS_DIR/gpg_pub.asc" ] || [ ! -f "$SECRETS_DIR/gpg_key_id" ]; then
  echo "WARNING: GPG secrets not found. Skipping. Run fetch_secrets.sh manually when ready."
  exit 0
fi

PUB_KEY_ID=$(cat "$SECRETS_DIR/gpg_key_id")
gpg --import "$SECRETS_DIR/gpg_pub.asc"
rm "$SECRETS_DIR/gpg_pub.asc" "$SECRETS_DIR/gpg_key_id"
echo "About to trust GPG key. Your input is required. Select '5'."
stty_save=$(stty -g)
trap "stty $stty_save" EXIT  # gpg --edit-key leaves terminal in raw mode; restore on exit or crash
gpg --edit-key "$PUB_KEY_ID" trust
stty "$stty_save"
trap - EXIT

if [ -f ~/.ssh/id_ed25519_github ]; then
  echo "GitHub SSH key already exists on this system."
else
  echo "About to generate new GitHub SSH key"
  read -p "Continue (y/n)? " choice
  if [[ ! "$choice" =~ ^[yY]$ ]]; then
    exit 0
  fi
  ssh-keygen -t ed25519 -C "$(git config --get github.user)@users.noreply.github.com" -f ~/.ssh/id_ed25519_github
  chmod 600 ~/.ssh/id_ed25519_github
  eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519_github
  echo "See https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account"
  open "https://github.com/settings/ssh/new"
fi
