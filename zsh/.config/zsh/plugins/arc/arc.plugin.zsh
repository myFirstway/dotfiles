# oh-my-zsh arc Theme
# some codes are derivatives from Sindre Sorhus' Pure theme
#
# Copyright (c) 2017-2022 Tamado Sitohang <ramot@ramottamado.dev>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

autoload -Uz async && async
autoload -Uz add-zsh-hook
add-zsh-hook precmd arc_precmd
add-zsh-hook preexec arc_preexec

arc_precmd() {
  # local -H MATCH MBEGIN MEND match mbegin mend

  arc_termsupport_precmd
  arc_async_tasks
  arc_render "precmd"

  # unset MATCH MBEGIN MEND match mbegin mend
}

arc_refresh() {
  # local -H MATCH MBEGIN MEND match mbegin mend

  arc_termsupport_precmd
  arc_async_tasks
  arc_render "refresh"

  # unset MATCH MBEGIN MEND match mbegin mend
}

arc_preexec() {
  arc_termsupport_preexec
}

arc_title() {
  local -H MATCH MBEGIN MEND match mbegin mend
  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  if [[ "$TERM" == screen* ]]; then
    print -Pn "\ek$1:q\e\\" #set screen hardstatus, usually truncated at 20 chars
  elif [[ "$TERM" == xterm* ]] || [[ "$TERM" == rxvt* ]] || [[ "$TERM" == ansi ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    print -Pn "\e]2;$2:q\a" #set window name
    print -Pn "\e]1;$1:q\a" #set icon (=tab) name
  fi
  unset MATCH MBEGIN MEND match mbegin mend
}

arc_termsupport_precmd() {
  ZSH_THEME_TERM_TAB_TITLE_IDLE="%-50<..<%1d%<<  —  zsh" #15 char left truncated PWD
  ZSH_THEME_TERM_TITLE_IDLE="%-50<..<%1d%<<  —  zsh"

  arc_title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

arc_termsupport_preexec() {
  setopt extended_glob

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  arc_title "%-50<..<%1d%<<: $CMD  —  zsh" "%-50<..<%1d%<<: $CMD  —  zsh"
}

arc_async_init() {
  typeset -g arc_async_init_started

  if (( ${arc_async_init_started:-0} )); then
    return
  fi

  arc_async_init_started=1
  async_start_worker "arc_prompt" -u -n
  async_register_callback "arc_prompt" arc_async_callback
}

arc_async_tasks() {
  setopt localoptions noshwordsplit

  # (( !${arc_async_init:-0} )) && {
  #   async_start_worker "arc_prompt" -u -n
  #   async_register_callback "arc_prompt" arc_async_callback
  #   arc_async_init=1
  # }

  arc_async_init

  async_worker_eval "arc_prompt" builtin cd -q $PWD

  typeset -gA arc_vcs_info

  local -H MATCH MBEGIN MEND match mbegin mend
  if [[ $PWD != ${arc_vcs_info[pwd]}* ]]; then
    # stop any running async jobs
    async_flush_jobs "arc_prompt"

    arc_vcs_info[branch]=
    arc_vcs_info[time]=
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  async_job "arc_prompt" arc_async_vcs_info

  [[ -n $arc_vcs_info[branch] ]] || return
}

arc_async_vcs_info() {
  setopt localoptions noshwordsplit

  # builtin cd -q $1 > /dev/null || return

  local -A info

  info[pwd]=$PWD
  info[branch]=$(arc_git_prompt)
  info[time]=$(_git_time_since_commit)

  print -r - ${(@kvq)info}
}

_git_time_since_commit() {
  setopt localoptions noshwordsplit

  # local ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[white]%}"
  local ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%F{8}"

  # Only proceed if there is actually a commit.
  local -H MATCH MBEGIN MEND match mbegin mend
  if git log -1 > /dev/null 2>&1; then
    # Get the last commit.
    local last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    local now=$EPOCHSECONDS
    local seconds_since_last_commit=$((now-last_commit))

    # Totals
    local minutes=$((seconds_since_last_commit / 60))
    local hours=$((seconds_since_last_commit / 3600))

    # Sub-hours and sub-minutes
    local days=$((seconds_since_last_commit / 86400))
    local sub_hours=$((hours % 24))
    local sub_minutes=$((minutes % 60))
    local color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL

    # Show age
    local commit_age=

    if [ $hours -gt 24 ]; then
      commit_age="${days}d"
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m"
    else
      commit_age="${minutes}m"
    fi

    # echo "$color$commit_age%{$reset_color%}"
    echo "$color$commit_age%f"
  fi
  unset MATCH MBEGIN MEND match mbegin mend
}

_suspend_symbol() {
  setopt localoptions noshwordsplit

  local ZSH_SUSPEND=" ⚐"
  local _suspended=

  local -H MATCH MBEGIN MEND match mbegin mend
  if [[ $(jobs -l | wc -l ) -gt 0 ]]; then
    _suspended=$ZSH_SUSPEND
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  echo $_suspended
}

arc_git_branch() {
  local g=$(command git rev-parse --git-dir 2> /dev/null)
  local r=
  local ref=

  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return

  local -H MATCH MBEGIN MEND match mbegin mend
  if [ -d "$g/rebase-merge" ]; then
    if [ -f "$g/rebase-merge/interactive" ]; then
      r="|%{$fg[cyan]%}REBASE-i%{$reset_color%}"
    else
      r="|%{$fg[blue]%}REBASE-m%{$reset_color%}"
    fi
  else
    if [ -d "$g/rebase-apply" ]; then
      if [ -f "$g/rebase-apply/rebasing" ]; then
        r="|%{$fg[green]%}REBASE%{$reset_color%}"
      elif [ -f "$g/rebase-apply/applying" ]; then
        r="|%{$fg[green]%}AM%{$reset_color%}"
      else
        r="|%{$fg[green]%}AM/REBASE%{$reset_color%}"
      fi
    elif [ -f "$g/MERGE_HEAD" ]; then
      r="|%{$fg[green]%}MERGING%{$reset_color%}"
    elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
      r="|%U%{$fg[magenta]%}CHERRY-PICKING%{$reset_color%}%u"
    elif [ -f "$g/REVERT_HEAD" ]; then
      r="|%{$fg[yellow]%}REVERTING%{$reset_color%}"
    elif [ -f "$g/BISECT_LOG" ]; then
      r="|%{$fg[blue]%}BISECTING%{$reset_color%}"
    fi
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  echo "%{$fg[green]%}%15<..<${ref#refs/heads/}%<<%{$reset_color%}$r"
}

### Git master •▾
arc_git_status() {
  local ZSH_THEME_GIT_PROMPT_AHEAD="%{\e[96m%}▴%{$reset_color%}"
  local ZSH_THEME_GIT_PROMPT_BEHIND="%{\e[95m%}▾%{$reset_color%}"
  local ZSH_THEME_GIT_PROMPT_STAGED="%{\e[92m%}•%{$reset_color%}"
  local ZSH_THEME_GIT_PROMPT_UNSTAGED="%{\e[93m%}•%{$reset_color%}"
  local ZSH_THEME_GIT_PROMPT_UNTRACKED="%{\e[91m%}•%{$reset_color%}"
  local _INDEX=$(git status --porcelain -b 2> /dev/null)
  local _STATUS=

  local -H MATCH MBEGIN MEND match mbegin mend
  if [[ $_INDEX =~ '\?\? ' ]]; then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi
  if [[ $_INDEX =~ $'\n.[MTD] ' ]]; then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi
  if [[ $_INDEX =~ $'\n[AMRDU]. ' ]]; then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi
  if [[ $_INDEX =~ ^'## .*ahead' ]]; then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if [[ $_INDEX =~ ^'## .*behind' ]]; then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  echo $_STATUS
}

arc_git_prompt() {
  local _branch=$(arc_git_branch)
  local _status=$(arc_git_status)
  local _result=

  local -H MATCH MBEGIN MEND match mbegin mend
  if [[ -n "${_branch}" ]]; then
    _result="• $_branch "
    if [[ -n "${_status}" ]]; then
      _result="$_result$_status"
    fi
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  echo $_result
}

_get_path() {
  local _PATH=

  _PATH="%{$fg[blue]%}%15<..<%1~%<<%{$reset_color%}"

  if [ -f /run/.containerenv ] && [ -f /run/.toolboxenv ]; then
    _PATH="%{\e[35m%}⬢%{$reset_color%} $_PATH"
  fi

  echo $_PATH
}

_venv_status() {
  local venv_name=

  local -H MATCH MBEGIN MEND match mbegin mend
  if [[ -n $CONDA_DEFAULT_ENV ]]; then
    venv_name+=" • %{\e[94m%}conda: %15<..<${CONDA_DEFAULT_ENV:t}%<<%{$reset_color%}"
  elif [[ -n $VIRTUAL_ENV ]]; then
    venv_name+=" • %{\e[94m%}venv: %15<..<${VIRTUAL_ENV:t}%<<%{$reset_color%}"
  fi
  if [[ -f .node-version ]]; then
    nodenv version-name &>/dev/null && venv_name+=" • %{\e[94m%}node: %15<..<$(nodenv version-name)%<<%{$reset_color%}"
  fi
  if [[ -f .ruby-version ]]; then
    rbenv version-name &>/dev/null && venv_name+=" • %{\e[94m%}ruby: %15<..<$(rbenv version-name)%<<%{$reset_color%}"
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  echo $venv_name
}

arc_async_callback() {
  setopt localoptions noshwordsplit

  local job=$1 code=$2 output=$3 exec_time=$4

  case $job in
    arc_async_vcs_info)
      local -A info
      typeset -gA arc_vcs_info

      info=("${(Q@)${(z)output}}")

      local -H MATCH MBEGIN MEND match mbegin mend
      if [[ $info[pwd] != $PWD ]]; then
        return
      fi
      unset MATCH MBEGIN MEND match mbegin mend

      arc_vcs_info[branch]=$info[branch]
      arc_vcs_info[time]=$info[time]
      arc_vcs_info[pwd]=$PWD
      venv_status=$(_venv_status)

      arc_render
      ;;
  esac
}

arc_render() {
  setopt localoptions noshwordsplit

  local -a arc_parts arc_rparts
  typeset -gA arc_vcs_info

  arc_parts+=("$(_get_path)")
  arc_parts+=("${venv_status}")

  local -H MATCH MBEGIN MEND match mbegin mend
  if [[ -n $arc_vcs_info[branch] ]]; then
    arc_parts+=(" ${arc_vcs_info[branch]% }")
  fi
  if [[ -n $arc_vcs_info[time] ]]; then
    arc_rparts+=("${arc_vcs_info[time]}")
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  arc_rparts+=("$(_suspend_symbol)")

  export PROMPT="${(j..)arc_parts} "
  export RPROMPT="${(j. .)arc_rparts}"
  export PROMPT2="  %{$fg[green]%}>%{$reset_color%} "
  export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color [Yes, No, Abort, Edit]? "

  local expanded_prompt
  expanded_prompt="${(S%%)PROMPT}"

  if [[ $1 == "precmd" ]]; then
    # do nothing
  elif [[ $prompt_arc_last_prompt != $expanded_prompt ]]; then
    zle && zle reset-prompt
  fi

  typeset -g prompt_arc_last_prompt=$expanded_prompt
}
