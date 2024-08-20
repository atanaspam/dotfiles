# This script creates a symlink for the .default-cloud-sdk-components defined in etc/config to $HOME/.config/gcloud

# Create the directory if it doesn't exist
mkdir -p $HOME/.config/gcloud

# Create the symlink
ln -sfnv $(pwd)/etc/config/.default-cloud-sdk-components $HOME/.config/gcloud/.default-cloud-sdk-components
