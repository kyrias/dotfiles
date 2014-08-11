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
       dotglob \
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

DEFAULT_COLOR="%{${fg[default]}%}"
function bold  { printf "%s%s%s" "%{%B%}" "$1" "%{%b%}" }
function red   { printf "%s%s%s" "%{${fg[red]}%}" "$1" "$DEFAULT_COLOR" }
function green { printf "%s%s%s" "%{${fg[green]}%}" "$1" "$DEFAULT_COLOR" }
function blue  { printf "%s%s%s" "%{${fg[blue]}%}" "$1" "$DEFAULT_COLOR" }
function cyan { printf "%s%s%s" "%{${fg[cyan]}%}" "$1" "$DEFAULT_COLOR" }
function magenta { printf "%s%s%s" "%{${fg[magenta]}%}" "$1" "$DEFAULT_COLOR" }
function yellow { printf "%s%s%s" "%{${fg[yellow]}%}" "$1" "$DEFAULT_COLOR" }
function black { printf "%s%s%s" "%{${fg[black]}%}" "$1" "$DEFAULT_COLOR" }
function white { printf "%s%s%s" "%{${fg[white]}%}" "$1" "$DEFAULT_COLOR" }
function prompt_user_color {
	(( UID )) && print -n red || print -n magenta
}

PROMPT="$(yellow "┌─[") $(yellow "$(bold %m)") \
$($(prompt_user_color) "$(bold %n)") \
$(blue "$(bold %~)") $(magenta $(bold '$branch'))$(yellow "]")
$(yellow "└─╼") "

function get_git_branch {
	if [[ -d .git ]]; then
		branch="$(git rev-parse --abbrev-ref HEAD) "
	else
		branch=""
	fi
}

# Print basic prompt to the window title
function precmd {
	print -Pn "\e];%n %~\a"
	get_git_branch
}

# Print the current running command's name to the window title
function preexec {
	local cmd=${1[(wr)^(*=*|sudo|exec|ssh|-*)]}
	print -Pn "\e];$cmd:q\a"
}

source "$ZDOTDIR"/aliases.zsh
source "$ZDOTDIR"/keybindings.zsh

[[ -f "$ZDOTDIR"/environ-"$(hostname -s)" ]] && \
    source "$ZDOTDIR"/environ-"$(hostname -s)"

if [[ -n "$VTE_VERSION" ]]; then
	source /etc/profile.d/vte.sh
	__vte_prompt_command
fi
