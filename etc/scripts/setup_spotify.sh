#!/usr/bin/env bash

eval "$(/opt/homebrew/bin/brew shellenv)" # TODO: Needs to be in every script

echo "About to obtain Spotify App Creds from Bitwarden."
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "yes";;
  n|N ) exit 0;;
  * ) echo "invalid";;
esac
echo $(which node)
echo -n "Enter account: "
read BW_ACCOUNT
echo -n "Enter password: "
read -s BW_PASS
bw config server https://vault.bitwarden.eu
export BW_SESSION=$(bw login $BW_ACCOUNT $BW_PASS --raw)
touch ~/.shpotify.cfg
CLIENT_ID=$(bw get item "Spotify" | jq --raw-output '.fields[] | select(.name == "Client ID") | .value')
CLIENT_SECRET=$(bw get item "Spotify" | jq --raw-output '.fields[] | select(.name == "Client Secret") | .value')
printf "CLIENT_ID=\"$CLIENT_ID\" \nCLIENT_SECRET=\"$CLIENT_SECRET\"" > ~/.shpotify.cfg
bw logout