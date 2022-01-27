skip_global_compinit=1

# envs
export PROMPT_EOL_MARK=""
export MPD_PORT="6600"
export PAGER="less"
export LESS="-~R" # output raw control chars
# export VISUAL='/bin/vim'
# export EDITOR='/bin/vim'
# export SELECTED_EDITOR='/bin/vim'

# dirs
export SPARK_HOME="$HOME/.local/share/sdkman/candidates/spark/current"
export PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip:$PYTHONPATH"
export PROJECT_HOME="$HOME/Documents/workspace/python"
export PYTHONSTARTUP="$HOME/.pythonrc"
export PYENV_ROOT="$HOME/.local/share/pyenv"
export RBENV_ROOT="$HOME/.local/share/rbenv"
export NODENV_ROOT="$HOME/.local/share/nodenv"
export SDKMAN_DIR="$HOME/.local/share/sdkman"
export GOPATH="$HOME/Documents/workspace/go"
export ZSH_SDKMAN_DIR="$HOME/.config/zsh-sdkman"
export TEXDIR="$HOME/.local/share/texlive/2021"
export TEXMFHOME="$HOME/.config/texmf"
export TEXMFVAR="$HOME/.config/texlive2021"
export TEXMFCONFIG="$TEXMFVAR/texmfconfig"

# java
if [ -z $JAVA_HOME ] && [ "$(command -v javac)" ]; then
  export JAVA_HOME="$(dirname $(dirname $(readlink $(readlink $(which javac)))))"
fi
# export JAVA_OPTS="-Xmx1024m"
# export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'    # Use GTK for Java
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
# export JAVA_TOOL_OPTIONS="-javaagent:/usr/share/java/jayatanaag.jar $JAVA_TOOL_OPTIONS" # Applications

# path
export PATH="$TEXDIR/bin/x86_64-linux:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$RBENV_ROOT/bin:$PATH"
export PATH="$NODENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/share/coursier/bin:$PATH"
# export PATH="$HOME/.cargo/bin:$PATH"
if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

# manpath & infopath
export MANPATH="$HOME/.local/share/man:$MANPATH"
export MANPATH="$TEXDIR/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$TEXDIR/texmf-dist/doc/info:$INFOPATH"

# language & region
if [[ -z "$LC_CTYPE" && -z "$LC_ALL" ]]; then
  export LC_CTYPE=${LANG%%:*} # pick the first entry from LANG
fi

# virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1 # disable venv prompt
# export WORKON_HOME=$HOME/.virtualenvs
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

# qt
# export QT_QPA_PLATFORMTHEME=qt5ct
# export QT_STYLE_OVERRIDE=kvantum

# vim
# alias vim="vimx"
# alias vi="vim"

# libreoffice
# export GTK2_RC_FILES=/home/ramot/.gtkrc-2.0
