# Add bin directory to path
if [[ -f "$HOME/bin" ]]; then
  PATH=$PATH:$HOME/bin
fi

# Adds `poetry` binary, should be added to the end:
PATH="$HOME/.poetry/bin:$PATH"
PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Make sure that asdf Terraform plugin uses the correct file for inferring versions.
export ASDF_HASHICORP_TERRAFORM_VERSION_FILE="versions.tf"

# Config for ZSH Plugins
# zsh-duration
export ZSH_DURATION_THRESHOLD=70

export GPG_KEYID=0x946281F6D65DA66F

# Usuful stuff for coloring terminal output
export BOLD=$(tput bold)
export RED=$(tput setaf 1)
export GREEN=$(tput setaf 2)
export YELLOW=$(tput setaf 3)
export BLUE=$(tput setaf 4)
export MAGENTA=$(tput setaf 5)
export RESET=$(tput sgr0)

export AWS_PROFILE=""

# This should be the last line:
export PATH
