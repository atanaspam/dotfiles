# For each alias in this list add a comment above it starting with two hashes ## to contain the documentation for it.
# If you want to hide an alias from the help command just add no comments or prefix the comment with a single hash.

# ## help: Print the list of aliases and their descriptions
alias help="print_help"

# projects: Take me to the projects dir
alias projects="cd ~/projects"

# playgrounds: Take me to the playgrounds dir
alias playgrounds="cd ~/playgrounds"

# docs:ignore
alias grep='grep --color=auto'

## racadm: Run racadm using docker
alias racadm="docker run --rm -it racadm:latest racadm"

## shrug: ¯\_(ツ)_/¯
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"

## emoji: Show emoji keyboard
alias emoji="echo 'Control(⌃) + ⌘ + Space'"

## ammend: Ammend the message of the last commit
alias amend="git commit --amend -C HEAD"

## tm: Show ™ sign
alias tm="echo ⌥ + fn + 2 = ™"

## reload: reload the current shell with the latest .zprofile, .zshrc config
alias reload="exec zsh"

## learn_yubikey: Learns all GPG keys stored in the currently plugged Yubikey.
alias learn_yubikey='gpg-connect-agent "scd serialno" "learn --force" /bye'

## reload_gpg_agent: Reloads the GPG agent in case its stuck
alias reload_gpg_agent='gpgconf --kill gpg-agent'

## reload_dns: reload the DNS cache
alias reload_dns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

## awsprofiles: List all locally available AWS profiles
alias awsprofiles="aws configure list-profiles"

## awscreds: Export AWS credentials for the current session as environment variables
alias awscreds="aws configure export credentials --format env"

alias awslogin="awsauth"

alias gcmsgt='git commit -m "test"'

