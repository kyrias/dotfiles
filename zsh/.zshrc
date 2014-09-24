HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=500000
SAVEHIST=500000

fpath=(~/.local/share/zsh/completion $fpath)
zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

autoload -Uz colors \
             compinit \
             promptinit \
             edit-command-line \
             run-help \
             zmv
compinit
promptinit
colors

zmodload zsh/mapfile

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

# Menu completion
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' rehash yes


source "$ZDOTDIR"/prompt.zsh
source "$ZDOTDIR"/aliases.zsh
source "$ZDOTDIR"/keybindings.zsh

[[ -f "$ZDOTDIR"/zshrc-"$(hostname -s)" ]] && \
    source "$ZDOTDIR"/zshrc-"$(hostname -s)"

if [[ -n "$VTE_VERSION" ]]; then
	source /etc/profile.d/vte.sh
	__vte_prompt_command
fi
