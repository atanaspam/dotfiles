# For each alias in this list add a comment above it starting with two hashes ## to contain the documentation for it.
# If you want to hide an alias from the help command just add no comments or prefix the comment with a single hash.

## help: Print the list of aliases and their descriptions
alias help="aliases"

## projects: Take me to the projects dir
alias projects="cd ~/projects"

## playgrounds: Take me to the playgrounds dir
alias playgrounds="cd ~/playgrounds"

# docs:ignore
alias grep='grep --color=auto'

## racadm: Run racadm using docker
alias racadm="docker run --rm -it racadm:latest racadm"

## shrug: ¯\_(ツ)_/¯
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"

## localip: Show local ip
alias localip="ipconfig getifaddr en0"

## emoji: Show emoji keyboard
alias emoji="Control + Command + Space"