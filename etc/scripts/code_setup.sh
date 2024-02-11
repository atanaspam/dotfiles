#!/bin/bash

eval "$(/opt/homebrew/bin/brew shellenv)" # TODO: Needs to be in every script that depends on tools installed by brew

for EXT in $(cat etc/config/vs_code_extentions ); do code --install-extension $EXT; done
