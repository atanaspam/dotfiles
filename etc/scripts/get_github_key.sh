#!/usr/bin/env bash

eval "$(/opt/homebrew/bin/brew shellenv)" # TODO: Needs to be in every script

echo "About to obtain GitHub SSH Key from Bitwarden."
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "yes";;
  n|N ) exit 0;;
  * ) echo "invalid";;
esac
echo -n "Enter account  : "
read BW_ACCOUNT
echo -n "Enter password : "
read -s BW_PASS
echo
export BW_SESSION=$(bw login $BW_ACCOUNT $BW_PASS --raw)
mkdir -p ~/.ssh
bw get notes 'GitHub SSH Key (private)' > ~/.ssh/id_ed25519_github
bw get notes 'GitHub SSH Key (public)' > ~/.ssh/id_ed25519_github.pub
chmod 600 ~/.ssh/id_ed25519_github
chmod 600 ~/.ssh/id_ed25519_github.pub
bw logout