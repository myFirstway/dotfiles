# alias
alias q='exit'
alias quit='exit'
alias :q='exit'
alias c='clear'
alias such='git'
alias very='git'
alias wow='git status'
alias workspace='cd $HOME/Documents/workspace'
alias vimpath='cd $HOME/Documents/workspace/git/vim'
alias dotfiles='cd $HOME/.dotfiles'
alias gf='cd $HOME/Documents/workspace/git'
alias blog='cd $HOME/Documents/workspace/git/blog'
alias skripsi='cd $HOME/Documents/workspace/python/skripsi'
alias apt='sudo apt'
alias apt-get='sudo apt-get'
alias dnf='sudo dnf'
alias gitinit='git init && git add -A && git commit -m "Initial Commit"'
alias fuck='sudo'
alias pbcopy='xclip -sel clip'
alias pbpaste='xclip -sel clip -o'
alias here='browse . &> /dev/null'
alias browsedir='nautilus $1 &> /dev/null'
alias ls='ls --color=tty'
alias ncmpcpp='ncmpcpp -q'
alias gc='git clone'
alias gA='git add -A'
alias commit='git commit -am'

# changing/making/removing directory
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias d='dirs -v | head -10'

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias l.='ls -d .*'

# grep
typeset GREP_OPTIONS=" --color=auto"

# export grep settings
alias grep="grep $GREP_OPTIONS"
alias egrep="egrep $GREP_OPTIONS"
alias fgrep="fgrep $GREP_OPTIONS"

# clean up
unset GREP_OPTIONS
