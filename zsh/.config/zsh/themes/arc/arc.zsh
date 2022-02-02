# arc theme
# some codes are derivatives from Sindre Sorhus' Pure theme and oh-my-zsh bureau theme
#
# for my own and others sanity
#
# git:
# %b => current branch
# %a => current action (rebase/merge)
#
# prompt (https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html):
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %d => cwd
# %(?..) => prompt conditional - %(condition.true.false)

typeset -g ARC_ASYNC_INIT_STARTED
typeset -g ARC_LAST_PROMPT
typeset -g ARC_VENV_STATUS
typeset -gA ARC_VCS_INFO

autoload -Uz async && async
autoload -Uz add-zsh-hook
add-zsh-hook precmd arc_precmd
add-zsh-hook preexec arc_preexec

## refresh the prompt
## useful when called from ZLE
arc_refresh() {
  arc_term_precmd
  arc_async_tasks
  arc_render "refresh"
}

## precmd zsh hook
arc_precmd() {
  arc_term_precmd
  arc_async_tasks
  arc_render "precmd"
}

## preexec zsh hook
arc_preexec() {
  setopt localoptions extended_glob

  # from prezto & omz
  # see https://stackoverflow.com/questions/45288905/zsh-mystery-variable-expansion
  # cmd name only, or if this is sudo or ssh, the next cmd
  typeset cmd="${${2[(wr)^(*=*|sudo|ssh|-*)]}:t}"

  # %-50<..< => truncate max 50 characters from right margin
  # %1d => cwd
  # %<< => end of truncation
  typeset term_tab_title="%-50<...<%1d%<<: $cmd  —  zsh"
  typeset term_window_title="%-50<...<%1d%<<: $cmd  —  zsh"

  arc_term_title $term_tab_title $term_window_title
}

## set terminal title
## will be called from precmd hook
arc_term_precmd() {
  typeset term_tab_title="%-50<...<%1d%<<  —  zsh" # 50 char left truncated PWD
  typeset term_window_title="%-50<...<%1d%<<  —  zsh"

  arc_term_title $term_tab_title $term_window_title
}

## set terminal window and tab/icon title
## forked from oh-my-zsh terminal library
## modified to work with my config
##
## usage: arc_term_title short_tab_title [long_window_title]
##
## see: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
## fully supports screen, iterm, and probably most modern xterm and rxvt
## (in screen, only short_tab_title is used)
arc_term_title() {
  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  typeset -H MATCH MBEGIN MEND match mbegin mend
  if [[ "$TERM" == screen* ]]; then
    print -Pn "\ek$1:q\e\\" # set screen hardstatus, usually truncated at 20 chars
  elif [[ "$TERM" == xterm* ]] || [[ "$TERM" == rxvt* ]] || [[ "$TERM" == ansi ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    print -Pn "\e]2;$2:q\a" # set window name
    print -Pn "\e]1;$1:q\a" # set icon (=tab) name
  fi
  unset MATCH MBEGIN MEND match mbegin mend
}

## init async worker & callback
## called when async tasks run
arc_async_init() {
  if (( ${ARC_ASYNC_INIT_STARTED:-0} )); then
    return
  fi

  ARC_ASYNC_INIT_STARTED=1
  async_start_worker "arc_prompt" -u -n
  async_register_callback "arc_prompt" arc_async_callback
}

## run async tasks
arc_async_tasks() {
  setopt localoptions noshwordsplit

  # initialize the async worker
  arc_async_init

  # update the current working directory of the async worker
  async_worker_eval "arc_prompt" builtin cd -q $PWD

  typeset -H MATCH MBEGIN MEND match mbegin mend
  if [[ $PWD != ${ARC_VCS_INFO[pwd]}* ]]; then
    # stop any running async jobs
    async_flush_jobs "arc_prompt"

    ARC_VCS_INFO[branch]=
    ARC_VCS_INFO[time]=
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  async_job "arc_prompt" arc_job_vcs_info
}

## callback for async job
arc_async_callback() {
  setopt localoptions noshwordsplit

  typeset job=$1 code=$2 output=$3 exec_time=$4 next_pending=$6
  typeset do_render=0

  case $job in
    \[async])
      # handle all the errors that could indicate a crashed async worker
      # see zsh-async documentation for the definition of the exit codes
      if (( code == 2 )) || (( code == 3 )) || (( code == 130 )); then
        # our worker died unexpectedly, try to recover immediately
        # TODO(mafredri): Do we need to handle next_pending
        #                 and defer the restart?
        ARC_ASYNC_INIT_STARTED=0
        async_stop_worker "arc_prompt"
        arc_async_init   # reinit the worker
        arc_async_tasks  # restart all tasks

        # reset render state due to restart
        unset arc_render_requested
      fi
      ;;
    \[async/eval])
      if (( code )); then
        # looks like async_worker_eval failed
        # rerun async tasks just in case
        arc_async_tasks
      fi
      ;;
    arc_job_vcs_info)
      typeset -A info=("${(Q@)${(z)output}}")

      typeset -H MATCH MBEGIN MEND match mbegin mend
      if [[ $info[pwd] != $PWD ]]; then
        return
      fi
      unset MATCH MBEGIN MEND match mbegin mend

      ARC_VCS_INFO[branch]=$info[branch]
      ARC_VCS_INFO[time]=$info[time]
      ARC_VCS_INFO[pwd]=$PWD
      ARC_VENV_STATUS=$(_get_venv_status)

      do_render=1
      ;;
  esac

  if (( next_pending )); then
    (( do_render )) && typeset -g arc_render_requested=1
    return
  fi

  [[ ${arc_render_requested:-$do_render} = 1 ]] && arc_render
  unset arc_render_requested
}

## render prompt
arc_render() {
  setopt localoptions noshwordsplit

  unset arc_render_requested

  typeset -a arc_parts arc_rparts

  arc_parts+=("$(_get_cwd)")

  typeset -H MATCH MBEGIN MEND match mbegin mend
  if [[ -n $ARC_VENV_STATUS ]]; then
    arc_parts+=("${ARC_VENV_STATUS}")
  fi
  if [[ -n $ARC_VCS_INFO[branch] ]]; then
    arc_parts+=("${ARC_VCS_INFO[branch]}")
  fi
  if [[ -n $ARC_VCS_INFO[time] ]]; then
    arc_rparts+=("${ARC_VCS_INFO[time]}")
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  arc_rparts+=("$(_is_suspended)")

  export PROMPT="${(j. .)arc_parts} "
  export RPROMPT="${(j. .)arc_rparts}"
  export PROMPT2="  %F{green}>%f "
  export SPROMPT="Correct %F{red}%R%f to %F{green}%r%f d[Yes, No, Abort, Edit]? "

  typeset expanded_prompt="${(S%%)PROMPT}"

  if [[ $1 == "precmd" ]]; then
    # do nothing
  elif [[ $ARC_LAST_PROMPT != $expanded_prompt ]]; then
    zle && zle reset-prompt
  fi

  ARC_LAST_PROMPT=$expanded_prompt
}

## job to get vcs info
arc_job_vcs_info() {
  setopt localoptions noshwordsplit

  typeset -A info

  info[pwd]=$PWD
  info[branch]=$(arc_git_prompt branch)
  info[time]=$(arc_git_prompt time)

  print -r - ${(@kvq)info}
}

## git prompt
arc_git_prompt() {
  typeset git_branch=$(_get_git_branch)
  typeset git_status=$(_get_git_status)
  typeset -a result

  typeset -H MATCH MBEGIN MEND match mbegin mend
  if [[ $1 == "branch" ]]; then
    if [[ -n "${git_branch}" ]]; then
      result+=("• $git_branch")
      if [[ -n "${git_status}" ]]; then
        result+=("$git_status")
      fi
    fi
  elif [[ $1 == "time" ]]; then
    result+=("$(_get_git_time_since_commit)")
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  echo ${(j. .)result}
}

## get git branch
_get_git_branch() {
  typeset gitdir=$(command git rev-parse --git-dir 2> /dev/null)
  typeset action
  typeset ref

  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return

  typeset -H MATCH MBEGIN MEND match mbegin mend
  if [ -d "$gitdir/rebase-merge" ]; then
    if [ -f "$gitdir/rebase-merge/interactive" ]; then
      action="|%F{cyan}rebase-i%f"
    else
      action="|%F{blue}rebase-m%f"
    fi
  else
    if [ -d "$gitdir/rebase-apply" ]; then
      if [ -f "$gitdir/rebase-apply/rebasing" ]; then
        action="|%F{green}rebase%f"
      elif [ -f "$gitdir/rebase-apply/applying" ]; then
        action="|%F{green}am%f"
      else
        action="|%F{green}am/rebase%f"
      fi
    elif [ -f "$gitdir/MERGE_HEAD" ]; then
      action="|%F{green}merge%f"
    elif [ -f "$gitdir/BISECT_LOG" ]; then
      action="|%F{blue}bisecting%f"
    elif [ -f "$gitdir/CHERRY_PICK_HEAD" ]; then
      if [ -d "$gitdir/sequencer" ]; then
        action="|%u%F{magenta}cherry-seq%f%u"
      else
        action="|%u%F{magenta}cherry%f%u"
      fi
    elif [ -f "$gitdir/REVERT_HEAD" ]; then
      action="|%F{yellow}revert%f"
    elif [ -d "$gitdir/sequencer" ]; then
      action="|%F{yellow}cherry-or-revert%f"
    fi
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  echo "%F{green}%15<..<${ref#refs/heads/}%<<%f$action"
}

## get git status
## git master •▾
_get_git_status() {
  typeset -a git_status

  typeset circle_icon="•"
  typeset git_prompt_ahead="%F{14}▴%f"
  typeset git_prompt_behind="%F{13}▾%f"
  typeset git_prompt_staged="%F{10}$circle_icon%f"
  typeset git_prompt_unstaged="%F{11}$circle_icon%f"
  typeset git_prompt_untracked="%F{9}$circle_icon%f"
  typeset git_index=$(git status --porcelain -b 2> /dev/null)

  typeset -H MATCH MBEGIN MEND match mbegin mend
  if [[ $git_index =~ '\?\? ' ]]; then
    git_status+=("$git_prompt_untracked")
  fi
  if [[ $git_index =~ $'\n.[MTD] ' ]]; then
    git_status+=("$git_prompt_unstaged")
  fi
  if [[ $git_index =~ $'\n[AMRDU]. ' ]]; then
    git_status+=("$git_prompt_staged")
  fi
  if [[ $git_index =~ ^'## .*ahead' ]]; then
    git_status+=("$git_prompt_ahead")
  fi
  if [[ $git_index =~ ^'## .*behind' ]]; then
    git_status+=("$git_prompt_behind")
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  echo ${(j..)git_status}
}

## get git time since commit
_get_git_time_since_commit() {
  setopt localoptions noshwordsplit

  # only proceed if there is actually a commit
  if git log -1 >/dev/null 2>&1; then
    # get the last commit
    typeset last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    typeset now=$EPOCHSECONDS
    typeset seconds_since_last_commit=$((now-last_commit))

    # totals
    typeset minutes=$((seconds_since_last_commit / 60))
    typeset hours=$((seconds_since_last_commit / 3600))

    # sub-hours and sub-minutes
    typeset days=$((seconds_since_last_commit / 86400))
    typeset sub_hours=$((hours % 24))
    typeset sub_minutes=$((minutes % 60))

    # show age
    typeset commit_age

    if [ $hours -gt 24 ]; then
      commit_age="${days}d"
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m"
    else
      commit_age="${minutes}m"
    fi

    echo "%F{8}$commit_age%f"
  fi
}

## get suspend symbol
_is_suspended() {
  setopt localoptions noshwordsplit

  typeset arc_suspend_symbol="±"
  typeset suspend_status=

  typeset -H MATCH MBEGIN MEND match mbegin mend
  if [[ $(jobs -l | wc -l) -gt 0 ]]; then
    suspend_status=$arc_suspend_symbol
  fi
  unset MATCH MBEGIN MEND match mbegin mend

  echo $suspend_status
}

## get cwd
_get_cwd() {
  typeset -a current_working_dir

  if [ -f /run/.containerenv ] && [ -f /run/.toolboxenv ]; then
    current_working_dir+=("%F{magenta}⬢%f")
  fi

  current_working_dir+=("%F{blue}%15<..<%1~%<<%f")

  echo ${(j. .)current_working_dir}
}

## get venv status
_get_venv_status() {
  typeset -a venv_name

  if [[ -n $CONDA_DEFAULT_ENV ]]; then
    venv_name+=("• %F{2}%15<..<${CONDA_DEFAULT_ENV:t}%<<%f")
  elif [[ -n $VIRTUAL_ENV ]]; then
    venv_name+=("• %F{2}%15<..<${VIRTUAL_ENV:t}%<<%f")
  fi
  if [[ -f .node-version ]]; then
    typeset nodenv_name=$(nodenv version-name 2>/dev/null)

    if [[ -n $nodenv_name ]]; then
      venv_name+=("• %F{2}%15<..<$nodenv_name%<<%f")
    fi
  fi
  if [[ -f .ruby-version ]]; then
    typeset rbenv_name=$(rbenv version-name 2>/dev/null)

    if [[ -n $rbenv_name ]]; then
      venv_name+=("• %F{1}%15<..<$rbenv_name%<<%f")
    fi
  fi

  echo ${(j. .)venv_name}
}
