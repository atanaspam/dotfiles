#!/bin/bash
set -e

if command -v brew &>/dev/null; then
  echo "${0}: brew is already installed"
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

DOTPATH="$(cd "$(dirname "$0")/../.." && pwd)"
echo "Running brew bundle..."
/opt/homebrew/bin/brew bundle --file="$DOTPATH/Brewfile"
