# forked from oh-my-zsh dircycle plugin
# (c) 2017 Tamado Sitohang, omz maintainers
# MIT License

# enables cycling through the directory stack using
# Ctrl+Shift+Left/Right
#
# left/right direction follows the order in which directories
# were visited, like left/right arrows do in a browser

# NO_PUSHD_MINUS syntax:
#  pushd +N: start counting from left of `dirs' output
#  pushd -N: start counting from right of `dirs' output

## cycle left
insert-cycledleft () {
  emulate -L zsh
  setopt nopushdminus

  builtin pushd -q -0 &>/dev/null || true
  zle reset-prompt
  _pyenv_virtualenv_hook
  # sleep 0.1
  arc_refresh
}
zle -N insert-cycledleft

## cycle right
insert-cycledright () {
  emulate -L zsh
  setopt nopushdminus

  builtin pushd -q +1 &>/dev/null || true
  zle reset-prompt
  _pyenv_virtualenv_hook
  # sleep 0.1
  arc_refresh
}
zle -N insert-cycledright

# add key bindings for iTerm2
bindkey "\e[1;6C" insert-cycledleft
bindkey "\e[1;6D" insert-cycledright
