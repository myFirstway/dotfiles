# Changing directories behaviour
setopt auto_cd
setopt auto_pushd
# setopt cdable_vars
setopt pushd_ignore_dups

# Completion behaviour
setopt always_to_end
setopt auto_menu
setopt complete_in_word
unsetopt menu_complete

# Expansion and globbing behaviour
unsetopt nomatch

# History behaviour
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt share_history

# Input/Output behaviour
setopt interactive_comments

# Job control behaviour
setopt long_list_jobs

# Prompting behaviour
setopt prompt_subst

# Scripts and functions behaviour
setopt multios

# ZLE behaviour
setopt beep
