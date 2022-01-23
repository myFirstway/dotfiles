# fzf
[ -f ~/.config/fzf.zsh ] && source ~/.config/fzf.zsh

export FZF_DEFAULT_OPTS='
  --color fg:#6a737d,hl:12,fg+:7,bg+:#fffbdd,hl+:12
  --color info:9,prompt:12,pointer:9,spinner:4,marker:13
  --color border:#eceef1,header:4
  --height 100% --no-bold --reverse
'

export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' --select-1 --exit-0"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

export FZF_CTRL_T_OPTS='--prompt=\/\ '
export FZF_CTRL_R_OPTS="--expect=ctrl-i"

function _fo() {
  local sel
  sel=($(__fsel))
  sel=$(head -2 <<< "$sel" | tail -1)
  if [ -n "$sel" ]; then
    xdg-open $sel
  fi
  zle reset-prompt
}

zle -N _fo
bindkey '^E' fzf-cd-widget
bindkey '^F' _fo