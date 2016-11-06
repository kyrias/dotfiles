HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=500000
SAVEHIST=500000

fpath+=("$XDG_CONFIG_HOME/zsh/themes")
zstyle :compinstall filename "$ZDOTDIR"/.zshrc

# Menu completion
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' rehash yes

# Colors for file completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz colors \
             compinit \
             promptinit \
             edit-command-line \
             run-help \
             zmv
compinit
promptinit
colors

setopt autocd \
       complete_aliases \
       glob_dots \
       extended_history \
       hist_verify \
       hist_ignore_space \
       inc_append_history_time \
       interactive_comments \
       numeric_glob_sort \
       no_bg_nice \
       print_exit_value \
       prompt_subst \
       notify

# "This associative array takes as keys the names of files; the resulting
# value is the content of the file"
zmodload zsh/mapfile

source "$ZDOTDIR"/keybindings.zsh
source "$ZDOTDIR"/aliases.zsh        # aliases and functions.

if [[ -n "$VTE_VERSION" ]]; then
	source /etc/profile.d/vte.sh
	__vte_prompt_command
fi

if [[ -f "$ZDOTDIR"/zshrc-"$SHORTHOST" ]]; then
	source "$ZDOTDIR"/zshrc-"$SHORTHOST"
fi

GPG_TTY=$(tty)
export GPG_TTY

prompt kyrias
