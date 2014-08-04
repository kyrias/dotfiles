HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=500000
SAVEHIST=500000
setopt notify

fpath=(~/.local/share/zsh/completion $fpath)
zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

al=(colors
	compinit
	promptinit
)
autoload -Uz $al
compinit
promptinit
colors

shellopts=(
	autocd
	complete_aliases
	extended_history
	hist_verify
	hist_ignore_all_dups
	hist_save_no_dups
	hist_ignore_space
	hist_reduce_blanks
	share_history
	inc_append_history
	interactive_comments
	numeric_glob_sort
	no_bg_nice
	print_exit_value
	prompt_subst
)
setopt $shellopts

zmodload zsh/mapfile

# Menu completion
zstyle ':completion:*' menu select

if [[ $TERM == xterm-termite && $DISPLAY == ":0" ]]; then
    . /etc/profile.d/vte.sh
    __vte_osc7
fi

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

###########################
## Aliasing and keybinding
##
alias wefree='weechat -a -r "/connect Freenode"'
alias ms='mbsync -c "$XDG_CONFIG_HOME/mbsyncrc" theos'

ls_options='-A -F --color=auto --group-directories-first'
alias ls="ls $ls_options"
alias lsa="ls $ls_options -hAX"
alias lla="ls $ls_options -lhA"

alias df='df -h'
alias ncmpcpp='ncmpcpp -c ~/.config/ncmpcpp/config'
alias '...'='../..'
alias mkdir='mkdir -vp'
alias acp='acp -g'
alias amv='amv -g'

# Colored man
man() {
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

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

alias sprin='curl -F "sprunge=<-" http://sprunge.us'
sprfile() {
	curl -F "sprunge=<$1" http://sprunge.us
}

[[ -S '/run/user/1000/keyring/gpg' ]] && export GPG_AGENT_INFO='/run/user/1000/keyring/gpg:0:1'
[[ -S '/run/user/1000/keyring/ssh' ]] && export SSH_AUTH_SOCK='/run/user/1000/keyring/ssh'
