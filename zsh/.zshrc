HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=500
SAVEHIST=500
setopt notify

fpath=(~/.local/share/zsh/completion $fpath)
zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

al=(colors
	compinit
	promptinit
	vcs_info
)
autoload -Uz $al
compinit
promptinit
colors

shellopts=(PROMPT_SUBST
		   completealiases
		   auto_cd
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

source /usr/share/doc/pkgfile/command-not-found.zsh

#zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:git*' stagedstr "✚ "
zstyle ':vcs_info:git*' unstagedstr "● "

zstyle ':vcs_info:git*' formats "｢%b %u%c%m｣"

zstyle ':vcs_info:*' enable git
precmd() {
	vcs_info
}

PS1=$'%{${fg[blue]}%}%B%~%b%{${fg[blue]}%} %B%#%b %{${fg[default]}%}'
#PS1=$'┌─[${fg[cyan]}%B%n%b ${fg[blue]}%B%~%b$fg[default]]\n└─╼ '
RPS1='%{${fg[blue]}%}${vcs_info_msg_0_}%{${fg[default]}%}'

# Vi keybindings
bindkey -v

# Bind "<command mode> H" to run-help (man pages)
bindkey -M vicmd 'H' run-help
bindkey "^R" history-incremental-search-backward

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'e' edit-command-line

###########################
## Aliasing and keybinding
##
alias wefree='weechat -a -r "/connect Freenode"'
ls_options='-F --color=auto --group-directories-first'
alias ls="ls $ls_options"
alias lsa="ls $ls_options -hAX"
alias lla="ls $ls_options -lhA"
alias df='df -h'
alias nano='nano -w' # No linewrap
alias ncmpcpp='ncmpcpp -c ~/.config/ncmpcpp/config'
alias 'cd..'='cd ..'
alias ',,'='..'
alias '...'='../..'
alias mkdir='mkdir -vp'
alias 'please?'='sudo $(history | tail -n1 | cut -c 8-)'
alias acp='acp -g'
alias amv='amv -g'

# Use 'git's completions with 'hub'
if type compdef >/dev/null; then
   compdef hub=git
fi

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

source ~/.config/zsh/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
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

alias sprin='curl -F "sprunge=<-" http://sprunge.us'
sprfile() {
	curl -F "sprunge=<$1" http://sprunge.us
}

GPG_AGENT_INFO=$(ss -xl | grep -o '/run/user/1000/keyring-.*/gpg')
[ -z "$GPG_AGENT_INFO" ] || export GPG_AGENT_INFO=$GPG_AGENT_INFO:0:1
SSH_AUTH_SOCK=$(ss -xl | grep -o '/run/user/1000/keyring-.*/ssh')
[ -z "$SSH_AUTH_SOCK" ] || export SSH_AUTH_SOCK
