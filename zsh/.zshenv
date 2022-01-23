skip_global_compinit=1

export SPARK_HOME="$HOME/.local/share/sdkman/candidates/spark/current"
export PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip:$PYTHONPATH"

export TEXDIR="$HOME/.local/share/texlive/2021"
export TEXMFHOME="$HOME/.config/texmf"
export TEXMFVAR="$HOME/.config/texlive2021"
export TEXMFCONFIG="$TEXMFVAR/texmfconfig"

export PATH="$TEXDIR/bin/x86_64-linux:$PATH"

export MANPATH="$TEXDIR/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$TEXDIR/texmf-dist/doc/info:$INFOPATH"

# # set GOPATH
# if [ -d "$HOME/Documents/workspace/go" ]; then
  # export GOPATH="$HOME/Documents/workspace/go"
  # PATH="$GOPATH/bin:$PATH"
# fi

# if [ -d "$HOME/.cabal/bin" ] ; then
    # PATH="$HOME/.cabal/bin:$PATH"
# fi

# # export QT_QPA_PLATFORMTHEME=qt5ct
# # export QT_STYLE_OVERRIDE=kvantum
# # if [ $XDG_SESSION_TYPE = "wayland" ]; then
# #     xhost +si:localuser:root
# # fi

# alias vim="vimx"
# alias vi="vim"

# export GTK2_RC_FILES=/home/ramot/.gtkrc-2.0
# export JAVA_OPTS="-Xmx1024m"
# export SAL_USE_VCLPLUGIN=qt5
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
