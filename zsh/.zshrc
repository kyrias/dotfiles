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

function get_git_branch {
    if [[ -d .git ]]; then
        branch=" $(git rev-parse --abbrev-ref HEAD) "
    else
        branch=" "
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


# Load all configs
#for f in ~/.config/zsh/zsh.d/*.zsh
#	source $f

PS1=$'%{${fg[blue]}%}%B%~%b%{${fg[blue]}%} %B%#%b %{${fg[default]}%}'
#PS1=$'┌─[${fg[cyan]}%B%n%b ${fg[blue]}%B%~%b$fg[default]]\n└─╼ '

# Vi keybindings
bindkey -v

# Bind "<command mode> H" to run-help (man pages)
bindkey -M vicmd 'H' run-help
bindkey "^R" history-incremental-pattern-search-backward
bindkey -M isearch '^M' accept-search # Don't run commands when retrieving from history

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'e' edit-command-line

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
source "$ZDOTDIR"/aliases.zsh

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

if [[ -n "$VTE_VERSION" ]]; then
    source /etc/profile.d/vte.sh
    __vte_prompt_command
fi
