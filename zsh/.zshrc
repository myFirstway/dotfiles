# profiling
# zmodload zsh/zprof

# define general things here

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

# set environment
export PROJECT_HOME="$HOME/Documents/workspace/python"
export PYTHONSTARTUP="$HOME/.pythonrc"
export PYENV_ROOT="$HOME/.local/share/pyenv"
export RBENV_ROOT="$HOME/.local/share/rbenv"
export NODENV_ROOT="$HOME/.local/share/nodenv"
export TEXDIR="$HOME/.local/share/texlive/2021"
export TEXMFHOME="$HOME/.config/texmf"
export TEXMFVAR="$HOME/.config/texlive2021"
export TEXMFCONFIG="$TEXMFVAR/texmfconfig"
export SDKMAN_DIR="$HOME/.local/share/sdkman"
export GOPATH="$HOME/Documents/workspace/go"
# export SPARK_HOME="/home/ramot/.local/share/sdkman/candidates/spark/current"
# export PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip:$PYTHONPATH"

if [ -z $JAVA_HOME ] && [ "$(command -v javac)" ]; then
  export JAVA_HOME="$(dirname $(dirname $(readlink $(readlink $(which javac)))))"
fi

# export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'    # Use GTK for Java
# export JAVA_TOOL_OPTIONS="-javaagent:/usr/share/java/jayatanaag.jar $JAVA_TOOL_OPTIONS" # Applications

export PROMPT_EOL_MARK=""
export MPD_PORT="6600"
export PAGER="less"
export LESS="-~R" # output raw control chars
# export VISUAL='/bin/vim'
# export EDITOR='/bin/vim'
# export SELECTED_EDITOR='/bin/vim'

# path
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$RBENV_ROOT/bin:$PATH"
export PATH="$NODENV_ROOT/bin:$PATH"
export PATH="$TEXDIR/bin/x86_64-linux:$PATH"
export PATH="$HOME/.local/share/coursier/bin:$PATH"
if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

# export PATH="$HOME/.cargo/bin:$PATH"

# manpath
export MANPATH="$HOME/.local/share/man:$MANPATH"
export MANPATH="$TEXDIR/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$TEXDIR/texmf-dist/doc/info:$INFOPATH"

# language & region
if [[ -z "$LC_CTYPE" && -z "$LC_ALL" ]]; then
  export LC_CTYPE=${LANG%%:*} # pick the first entry from LANG
fi

# sourcing
eval `dircolors $ZSH/dircolors`
source $ZSH/function.zsh
fpath+=$ZSH/function

# init
if [[ $TERM == "xterm-256color" || $TERM == "screen-256color" || $TERM == "xterm-kitty" ]]; then
  source $ZSH/init.zsh
else
  source $ZSH/plugins/history/history.plugin.zsh
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

# zsh-autosuggestions
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=send-break  # fix no bell sound on Ctrl-G

# virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1 # disable venv prompt
# export WORKON_HOME=$HOME/.virtualenvs
# VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

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

# Completion
compinit -d $ZSH_CACHE_DIR/zcompdump
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /bin/gocomplete go
# source "${SDKMAN_DIR}/contrib/completion/zsh/sdk"

# zprof
