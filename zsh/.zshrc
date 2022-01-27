# profiling
# zmodload zsh/zprof

# define zsh home
ZSH="$HOME/.config/zsh"

# define zsh cache
ZSH_CACHE_DIR="$ZSH/cache"

# autoload
autoload -U colors && colors
autoload -U compinit

# zmodload
zmodload zsh/datetime
zmodload zsh/parameter
zmodload zsh/zle

# sourcing
eval `dircolors $ZSH/dircolors`
source $ZSH/function.zsh
fpath+=$ZSH/function

# init
if [[ $TERM == "xterm-256color" || $TERM == "screen-256color" || $TERM == "xterm-kitty" ]]; then
  source $ZSH/init.zsh
else
  source $ZSH/plugins/history/history.zsh
fi

# show todo
# if [[ $(todo) != '' ]]; then
 # JOAO="$fg_bold[white]TODO:$reset_color"
 # echo $JOAO
 # todo --filter -done +children
# fi

# show fortune
# if [[ $TERM == "xterm-256color" || $TERM == "screen-256color" ]]; then
  # local fortune=$(fortune $HOME/Documents/resources/fortune/bible/proverbs)
  # echo "$fg_bold[green]$fortune$reset_color"
# fi

# vim terminal
[[ -n "$VIM" ]] && echo -e -n "\x1b[\x35 q"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# nodenv
eval "$(nodenv init -)"

# rbenv
eval "$(rbenv init -)"

# SDKMAN
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# completion
compinit -d $ZSH_CACHE_DIR/zcompdump
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /bin/gocomplete go
# source "${SDKMAN_DIR}/contrib/completion/zsh/sdk"

# zprof
