## Command history configuration
HISTFILE=$HOME/.zsh_history

HISTSIZE=1000000
SAVEHIST=1000000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

# Ensure unique
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=on
