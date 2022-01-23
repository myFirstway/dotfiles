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
alias dotfiles='cd $HOME/Documents/dotfiles'
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

# LESS_TERMCAP
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1) # red
export LESS_TERMCAP_md=$(tput bold; tput setaf 1) # red
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput setaf 15; tput setab 7) # reverse
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 2) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1 # For Konsole and Gnome-terminal

# reload zshrc
function reload()
{
  local cache=$ZSH_CACHE_DIR
  autoload -U compinit zrecompile
  compinit -d "$cache/zcompdump"

  for f in ~/.zshrc "$cache/zcompdump"; do
    zrecompile -p $f && command rm -f $f.zwc.old
  done

  source ~/.zshrc
}

# zsh highlight
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green
ZSH_HIGHLIGHT_STYLES[path]=fg=4,bold
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=3
ZSH_HIGHLIGHT_STYLES[assign]=fg=10
ZSH_HIGHLIGHT_STYLES[globbing]=fg=11
ZSH_HIGHLIGHT_STYLES[comment]=fg=245
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245,underline'

# history substring search
HISTORY_SUBSTRING_SEARCH_FUZZY=true
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=10,fg=0"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=9,fg=0"

# unset
local -H MATCH MBEGIN MEND match mbegin mend
unset MATCH MBEGIN MEND match mbegin mend

# gitignore
function gitignore() {
  curl -sL https://www.gitignore.io/api/$1 -o .gitignore
}
