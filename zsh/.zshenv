skip_global_compinit=1

export SPARK_HOME="/home/ramot/.local/share/sdkman/candidates/spark/current"
export PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip:$PYTHONPATH"

export TEXDIR="$HOME/.local/share/texlive/2021"
export TEXMFHOME="$HOME/.config/texmf"
export TEXMFVAR="$HOME/.config/texlive2021"
export TEXMFCONFIG="$TEXMFVAR/texmfconfig"

export PATH="$TEXDIR/bin/x86_64-linux:$PATH"

export MANPATH="$TEXDIR/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$TEXDIR/texmf-dist/doc/info:$INFOPATH"
