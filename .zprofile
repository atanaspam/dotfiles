# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Editor
export EDITOR=vim
export GIT_EDITOR="${EDITOR}"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'

#??
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# https://github.com/asdf-vm/asdf/issues/692#issuecomment-642748733
autoload -U +X bashcompinit && bashcompinit

export GOPATH=$HOME/go
export PATH=~/bin:/opt/homebrew/bin:$GOPATH/bin:$PATH

autoload -Uz +X compinit && compinit
