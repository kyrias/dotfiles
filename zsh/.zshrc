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

source "$ZDOTDIR"/aliases.zsh
source "$ZDOTDIR"/keybindings.zsh

zle -N edit-command-line

if [[ -n "$VTE_VERSION" ]]; then
    source /etc/profile.d/vte.sh
    __vte_prompt_command
fi
