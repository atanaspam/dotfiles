#!/bin/bash
set -e

eval "$(/opt/homebrew/bin/brew shellenv)" # TODO: Needs to be in every script

echo "Configuring GNUPG"
chown -R $(whoami) ~/.gnupg/

bw config server https://vault.bitwarden.eu > /dev/null
if ! bw login --check > /dev/null; then
  echo -n "Enter account: "
  read BW_ACCOUNT
  echo -n "Enter password: "
  read -s BW_PASS
  BW_SESSION="$(bw login --raw "$BW_ACCOUNT" "$BW_PASS")"
  export BW_SESSION
fi
if ! bw unlock --check > /dev/null; then
  echo -n "Enter password: "
  read -s BW_PASS
  BW_SESSION="$(bw unlock --raw "$BW_PASS")"
fi

echo "Setting up personal keys"
PUB_KEY_SECRET_ID=$(bw get item "PGP" | jq --raw-output '.id')
PUB_KEY_SECRET_NAME=$(bw get item "PGP" | jq --raw-output '.attachments[] | select(.fileName | startswith("gpg")) .fileName')
PUB_KEY_ID=$(bw get item "PGP" | jq --raw-output '.fields[] | select(.name == "KeyId") | .value')
bw get attachment $PUB_KEY_SECRET_NAME --itemid $PUB_KEY_SECRET_ID --output /tmp/$PUB_KEY_SECRET_NAME
gpg --import /tmp/$PUB_KEY_SECRET_NAME
echo "About to trust PGP key. Your input is required. Select '5'."
gpg --edit-key $PUB_KEY_ID trust

echo "Setting up GitHub GPG key"
echo -n "Paste in the GPG Key ID for this device"
read -s GPG_KEY_ID
# https://stackoverflow.com/a/40027637
GITHUB_KEY_SECRET_NAME=$(bw get item "PGP" | jq --arg GPG_KEY_ID "$GPG_KEY_ID" --raw-output '.attachments[] | select(.fileName | startswith("$GPG_KEY_ID")) .fileName')
bw get attachment $GITHUB_KEY_SECRET_NAME --itemid $PUB_KEY_SECRET_ID --output /tmp/$GITHUB_KEY_SECRET_NAME
gpg --import /tmp/$GITHUB_KEY_SECRET_NAME
rm /tmp/$GITHUB_KEY_SECRET_NAME
bw logout


if [ -f ~/.ssh/id_ed25519_github ]; then
  echo "GitHub SSH key already exists on this system."
else
  echo "About to generate new GitHub SSH key"
  read -p "Continue (y/n)?" choice
  case "$choice" in
    y|Y ) echo "yes";;
    n|N ) exit 0;;
    * ) echo "invalid";;
  esac
  ssh-keygen -t ed25519 -C "$(git config --get github.user)@users.noreply.github.com" -f ~/.ssh/id_ed25519_github
  eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519_github
  echo "See https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account"
fi
