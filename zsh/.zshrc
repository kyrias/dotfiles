HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=500000
SAVEHIST=500000

zstyle :compinstall filename "$ZDOTDIR"/.zshrc

# Menu completion
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' rehash yes

fpath=("$ZDOTDIR"/completion "${fpath[@]}")

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
       hist_ignore_all_dups \
       hist_save_no_dups \
       hist_ignore_space \
       hist_reduce_blanks \
       inc_append_history \
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
source "$ZDOTDIR"/prompt.zsh         # sets the prompt

if [[ -n "$VTE_VERSION" ]]; then
	source /etc/profile.d/vte.sh
	__vte_prompt_command
fi

if [[ -f "$ZDOTDIR"/zshrc-"$SHORTHOST" ]]; then
	source "$ZDOTDIR"/zshrc-"$SHORTHOST"
fi

GPG_TTY=$(tty)
export GPG_TTY
