##
# Aliases and functions
#

# Don't have run-help aliased to man
unalias run-help
alias help=run-help

alias '...'='../..'
alias '....'='../../..'

ls_options=('--almost-all' '--classify'  '--color=auto'
            '--human-readable' '--group-directories-first'
            '-v') # Natural sort
alias ls='\ls "${ls_options[@]}"'
alias ll='\ls "${ls_options[@]}" -l'

alias grep='\grep --color'

alias mkdir='mkdir -vp'
alias df='df -h'

alias acp='acp -g'
alias amv='amv -g'

alias ncmpcpp='ncmpcpp -c ~/.config/ncmpcpp/config'
alias wefree='weechat -a -r "/connect Freenode"'
alias msa='mbsync --config "$XDG_CONFIG_HOME/mbsyncrc" -a'

alias pt='pstree --highlight-all --long --uid-changes'

alias sprin='curl -F "sprunge=<-" http://sprunge.us'
sprfile() {
	curl -F "sprunge=<$1" http://sprunge.us
}

# Colored man
man() {
	env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;43m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

sp() { printf '%s' "$@"; printf '\n'; }

have() { command -v "$1" >&/dev/null; }

# service management
if have systemctl && [[ -d /run/systemd/system ]]; then
	alias ssctl='sudo systemctl'
	alias userctl='systemctl --user'

	alias list='systemctl list-units -t path,service,socket --no-legend'
	alias ulist='userctl list-units -t path,service,socket --no-legend'

	alias lcstatus='loginctl session-status $XDG_SESSION_ID'
	alias tsd='tree /etc/systemd/system'

	cgls() { SYSTEMD_PAGER='cat' systemd-cgls "$@"; }
	usls() { cgls "/user.slice/user-$UID.slice/$*"; }
	psls() { cgls "/user.slice/user-$UID.slice/session-$XDG_SESSION_ID.scope"; }
fi

tt() {
	if [[ -n "$@" ]]; then
		print "$@" | ts '[%Y-%m-%d %H:%M:%S]' >> "$HOME"/documents/timetracking
	fi
}
