#!/bin/bash

# This script creates a symlink for the .default-cloud-sdk-components defined in etc/config to $HOME/.config/gcloud

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# Create the directory if it doesn't exist
mkdir -p "$HOME/.config/gcloud"

# Create the symlink
ln -sfnv "$REPO_ROOT/etc/config/.default-cloud-sdk-components" "$HOME/.config/gcloud/.default-cloud-sdk-components"
