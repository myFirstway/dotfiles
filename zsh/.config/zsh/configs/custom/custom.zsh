# LESS_TERMCAP
export LESS_TERMCAP_mb=$(printf '\33[1;31m]') # red
export LESS_TERMCAP_md=$(printf '\33[1;31m') # red
export LESS_TERMCAP_me=$(printf '\33[0;10m')
export LESS_TERMCAP_so=$(printf '\33[97;40m') # reverse
export LESS_TERMCAP_se=$(printf '\33[27;0;10m')
export LESS_TERMCAP_us=$(printf '\33[4;1;32m') # white
export LESS_TERMCAP_ue=$(printf '\33[24;0;10m')
export LESS_TERMCAP_mr=$(printf '\33[7m')
export LESS_TERMCAP_mh=$(printf '\33[2m')
export GROFF_NO_SGR=1 # for Konsole and gnome-terminal

# zsh highlight
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green
ZSH_HIGHLIGHT_STYLES[path]=fg=4,bold
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=3
ZSH_HIGHLIGHT_STYLES[assign]=fg=10
ZSH_HIGHLIGHT_STYLES[globbing]=fg=11
ZSH_HIGHLIGHT_STYLES[comment]=fg=245

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245,underline'
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=send-break  # fix no bell sound on Ctrl-G

# history substring search
HISTORY_SUBSTRING_SEARCH_FUZZY=true
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=10,fg=0"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=9,fg=0"

# unset
local -H MATCH MBEGIN MEND match mbegin mend
unset MATCH MBEGIN MEND match mbegin mend
