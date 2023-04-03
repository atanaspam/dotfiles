typeset -gx -U path
path=( \
    /usr/local/bin(N-/) \
    ~/bin(N-/) \
    "$path[@]" \
)

# set fpath before compinit
typeset -gx -U fpath
fpath=( \
    ~/.zsh/functions(N-/) \
    ~/.zsh/plugins/zsh-completions(N-/) \
    $fpath \
)
