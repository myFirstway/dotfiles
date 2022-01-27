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
