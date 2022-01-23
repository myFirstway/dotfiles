GREP_OPTIONS=" --color=auto"

# export grep settings
alias grep="grep $GREP_OPTIONS"
alias egrep="egrep $GREP_OPTIONS"
alias fgrep="fgrep $GREP_OPTIONS"

# clean up
unset GREP_OPTIONS
