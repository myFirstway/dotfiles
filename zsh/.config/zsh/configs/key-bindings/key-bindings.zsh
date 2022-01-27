# key bindings for my zsh config
# forked from oh-my-zsh keybindings library
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# make sure that the terminal is in application mode when zle is active
# since only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e                                            # Use emacs key bindings

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

# is this really necessary?
# bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey '^k' kill-region                              # [Ctrl-k] - Kill from the cursor to the mark
# bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
# bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
# if [[ "${terminfo[kpp]}" != "" ]]; then
  # bindkey "${terminfo[kpp]}" up-line-or-history       # [PageUp] - Up a line of history
# fi
# if [[ "${terminfo[knp]}" != "" ]]; then
  # bindkey "${terminfo[knp]}" down-line-or-history     # [PageDown] - Down a line of history
# fi

# bind terminal-specific up and down keys
# bind in both emacs and vi modes so it works in both
if [[ -n "$terminfo[kcuu1]" ]]; then
  bindkey -M emacs "$terminfo[kcuu1]" history-substring-search-up
  bindkey -M viins "$terminfo[kcuu1]" history-substring-search-up
fi
if [[ -n "$terminfo[kcud1]" ]]; then
  bindkey -M emacs "$terminfo[kcud1]" history-substring-search-down
  bindkey -M viins "$terminfo[kcud1]" history-substring-search-down
fi

# Home and End
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi
bindkey ' ' magic-space                               # [Space] - do history expansion
bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi
# bindkey '^?' backward-delete-char                     # [Backspace] - delete backward (conflict with autopair)
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# edit the current command line in $EDITOR
# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word

# consider emacs keybindings:
bindkey '\e[OH' beginning-of-line
bindkey '\e[OF' end-of-line

# completion
bindkey '^I' expand-or-complete-prefix

# bindkey -e  ## emacs key bindings

# bindkey '^[[A' up-line-or-search
# bindkey '^[[B' down-line-or-search
# bindkey '^[^[[C' emacs-forward-word
# bindkey '^[^[[D' emacs-backward-word

# bindkey -s '^X^Z' '%-^M'
# bindkey '^[e' expand-cmd-path
# bindkey '^[^I' reverse-menu-complete
# bindkey '^X^N' accept-and-infer-next-history
# bindkey '^W' kill-region
# bindkey '^I' complete-word

# Fix weird sequence that rxvt produces
# bindkey -s '^[[Z' '\t'

# stop mapping Ctrl+S
stty -ixon
stty -ixoff

# key-binding for tmux
# bindkey '\e[1~'   beginning-of-line   # Linux console
# bindkey '\e[H'    beginning-of-line   # xterm
# bindkey '\eOH'    beginning-of-line   # gnome-terminal
# bindkey '\e[2~'   overwrite-mode      # Linux console, xterm, gnome-terminal
# bindkey '\e[3~'   delete-char         # Linux console, xterm, gnome-terminal
# bindkey '\e[4~'   end-of-line         # Linux console
# bindkey '\e[F'    end-of-line         # xterm
# bindkey '\eOF'    end-of-line         # gnome-terminal

# if [[ $TERM == 'xterm' || $TERM == 'xterm-256color' ]]; then
#   echo -e -n "\x1b[\x35 q"              # xterm cursor
# fi
