#####################################################################
### Custom config start
#####################################################################

# Configure paths
# export PATH=$PATH:$HOME/scripts
# export GOPATH=$HOME/go
# export GOROOT=/opt/homebrew/opt/go/libexec
# export GOBIN=$GOPATH/bin
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin


# Initialize plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit snippet OMZP::sublime
zinit snippet OMZP::pip
zinit snippet OMZP::git
zinit ice svn; zinit snippet OMZP::macos
zinit snippet OMZP::colorize
zinit snippet OMZP::gitignore
zinit snippet OMZP::asdf
zinit snippet OMZP::kubectl
# zinit load direnv/direnv
zinit load rtakasuke/zsh-duration
zinit load paulirish/git-open
zinit load bartboy011/cd-reminder
zinit load zsh-users/zsh-history-substring-search
zinit ice from'gh-r' as'program'
zinit light sei40kr/fast-alias-tips-bin
zinit light sei40kr/zsh-fast-alias-tips

zinit as'completion' for OMZP::{'golang/_golang','pip/_pip','terraform/_terraform'}

zinit ice \
    as"completion" \
    id-as"poetry-completion" \
    has"poetry" \
    atclone"poetry completions zsh > _poetry" \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null

zinit fpath -f /opt/homebrew/share/zsh/site-functions
autoload compinit; compinit

zinit cdreplay -q


# config for ZSH Plugins
# zsh-duration
export ZSH_DURATION_THRESHOLD=70
# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# endconfig for ZSH Plugins

source "$HOME/.zsh/10_inital.zsh"
source "$HOME/.zsh/20_functions.zsh"
source "$HOME/.zsh/30_aliases.zsh"
source "$HOME/.zsh/40_exports.zsh"
for f in $HOME/.zsh/*_secret*.zsh; do source $f; done
source "$HOME/.zsh/80_visual.zsh"
source "$HOME/.zsh/90_final.zsh"
