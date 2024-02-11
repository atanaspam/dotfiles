# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
zinit ice svn; zinit snippet OMZ::plugins/macos
zinit snippet OMZP::colorize
zinit snippet OMZP::gitignore
zinit snippet OMZP::asdf
zinit snippet https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
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
autoload compinit; compinit # should this go in zprofile?

zinit cdreplay -q


# config for ZSH Plugins
# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# end config for ZSH Plugins

source "$HOME/.zsh/10_inital.zsh"
source "$HOME/.zsh/20_functions_internal.zsh"
source "$HOME/.zsh/21_functions.zsh"
source "$HOME/.zsh/30_aliases.zsh"
source "$HOME/.zsh/40_exports.zsh"
for f in $HOME/.zsh/*_secret*.zsh; do source $f; done
source "$HOME/.zsh/80_visual.zsh"
source "$HOME/.zsh/90_final.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
