# Set terminal window and tab/icon title
# forked from oh-my-zsh terminal library
# modified to work with my config
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen, iterm, and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
# Limited support for Apple Terminal (Terminal can't set window and tab separately)

ZSH_THEME_TERM_TAB_TITLE_IDLE="%-50<..<%1d%<<  —  zsh" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%-50<..<%1d%<<  —  zsh"

function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  if [[ "$TERM" == screen* ]]; then
    print -Pn "\ek$1:q\e\\" #set screen hardstatus, usually truncated at 20 chars
  elif [[ "$TERM" == xterm* ]] || [[ "$TERM" == rxvt* ]] || [[ "$TERM" == ansi ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    print -Pn "\e]2;$2:q\a" #set window name
    print -Pn "\e]1;$1:q\a" #set icon (=tab) name
  fi
}

# Runs before showing the prompt
function arc_termsupport_precmd {
  emulate -L zsh
  if [[ $DISABLE_AUTO_TITLE == true ]]; then
    return
  fi

  title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function arc_termsupport_preexec {
  emulate -L zsh
  if [[ $DISABLE_AUTO_TITLE == true ]]; then
    return
  fi

  setopt extended_glob

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title "%-50<..<%1d%<<: $CMD  —  zsh" "%-50<..<%1d%<<: $CMD  —  zsh"
  # print -Pn "\e]0;$2  —  zsh  —  $COLUMNS✕$LINES\a"
  # echo -nE "$2  —  $(hostname -s)"
  # print -Pn "\a"
}

precmd_functions+=(arc_termsupport_precmd)
preexec_functions+=(arc_termsupport_preexec)
