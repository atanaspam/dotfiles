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

# Configure all homebrwew variables
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=~/bin:$GOPATH/bin:$PATH
