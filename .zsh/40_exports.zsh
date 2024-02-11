# Add bin directory to path
if [[ -f "$HOME/bin" ]]; then
  PATH=$PATH:$HOME/bin
fi

# GPG agent:
PATH="/usr/local/opt/gpg-agent/bin:$PATH"

# Adds `poetry` binary, should be added to the end:
PATH="$HOME/.poetry/bin:$PATH"

# Make sure that asdf Terraform plugin uses the correct file for inferring versions.
export ASDF_HASHICORP_TERRAFORM_VERSION_FILE="versions.tf"

# Config for ZSH Plugins
# zsh-duration
export ZSH_DURATION_THRESHOLD=70

export KEYID=0x946281F6D65DA66F

# This should be the last line:
export PATH
