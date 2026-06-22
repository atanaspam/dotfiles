# Add bin directory to path
if [[ -d "$HOME/bin" ]]; then
  PATH=$PATH:$HOME/bin
fi

# Not required anymore
# export GOPATH=$HOME/go

# Make sure the ASDF tools are resolved first:
export ASDF_DATA_DIR="$HOME/.asdf"

# Make sure that asdf Terraform plugin uses the correct file for inferring versions.
export ASDF_HASHICORP_TERRAFORM_VERSION_FILE="versions.tf"


# Config for ZSH Plugins
# zsh-duration
export ZSH_DURATION_THRESHOLD=70

export GPG_KEYID=0x946281F6D65DA66F

# Obsidian Vaults
export VAULTS_LOCATION="$HOME/vaults"
export DEFAULT_VAULT="i3d"
export VAULT_LOCATION="$VAULTS_LOCATION/$DEFAULT_VAULT"

# Dotfiles repo location (used by scripts and aliases that reference repo-relative paths)
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/projects/dotfiles}"

# Usuful stuff for coloring terminal output
export BOLD=$(tput bold)
export RED=$(tput setaf 1)
export GREEN=$(tput setaf 2)
export YELLOW=$(tput setaf 3)
export BLUE=$(tput setaf 4)
export MAGENTA=$(tput setaf 5)
export RESET=$(tput sgr0)

export AWS_PROFILE=""

# Added by LM Studio CLI (lms)
export PATH="$PATH:~/.lmstudio/bin"

# Deduplicate PATH entries
typeset -U PATH

# This should be the last line:
export PATH
