##
# Aliases and functions
#

alias '...'='../..'

ls_options=('--almost-all' '--classify'  '--color=auto'
            '--human-readable' '--group-directories-first')
alias ls='\ls "${ls_options[@]}"'
alias ll='\ls "${ls_options[@]}" -l'

alias mkdir='mkdir -vp'
alias df='df -h'

alias acp='acp -g'
alias amv='amv -g'

alias ncmpcpp='ncmpcpp -c ~/.config/ncmpcpp/config'
alias wefree='weechat -a -r "/connect Freenode"'
alias ms='mbsync -c "$XDG_CONFIG_HOME/mbsyncrc" theos'

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
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

sp() { printf '%s' "$@"; printf '\n'; }

have() { command -v "$1" >&/dev/null; }

## service management
if have systemctl && [[ -d /run/systemd/system ]]; then
	alias sd='systemctl'
	alias u='systemctl --user'
	alias list='systemctl list-units -t path,service,socket --no-legend'
	alias lcstatus='loginctl session-status $XDG_SESSION_ID'
	alias tsd='tree /etc/systemd/system'

	start()   { sudo systemctl start "$@";   systemctl status -a "$@"; }
	stop()    { sudo systemctl stop "$@";    systemctl status -a "$@"; }
	restart() { sudo systemctl restart "$@"; systemctl status -a "$@"; }
	reload()  { sudo systemctl reload "$@";  systemctl status -a "$@"; }
	status()  { systemctl status -a "$@"; }

	alias userctl='systemctl --user'
	alias ulist='userctl list-units -t path,service,socket --no-legend'
	ustart()   { userctl start "$@";   userctl status -a "$@"; }
	ustop()    { userctl stop "$@";    userctl status -a "$@"; }
	urestart() { userctl restart "$@"; userctl status -a "$@"; }
	ureload()  { userctl reload "$@";  userctl status -a "$@"; }

	cgls() { SYSTEMD_PAGER='cat' systemd-cgls "$@"; }
	usls() { cgls "/user.slice/user-$UID.slice/$*"; }
	psls() { cgls "/user.slice/user-$UID.slice/session-$XDG_SESSION_ID.scope"; }
fi
