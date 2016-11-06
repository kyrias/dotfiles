##
# Aliases and functions
#

alias '...'='../..'

ls_options=('--almost-all' '--classify'  '--color=auto'
            '--human-readable' '--group-directories-first')
alias ls='\ls "${ls_options[@]}"'
alias ll='\ls "${ls_options[@]}" -l'

alias grep='\grep --color'

alias mkdir='mkdir -vp'
alias df='df -h'

alias acp='acp -g'
alias amv='amv -g'

alias ncmpcpp='ncmpcpp -c ~/.config/ncmpcpp/config'
alias wefree='weechat -a -r "/connect Freenode"'
alias ms='mbsync --config "$XDG_CONFIG_HOME/mbsyncrc" theos'
alias ms5='mbsync --config "$XDG_CONFIG_HOME/mbsyncrc" 5monkeys'
alias msa='mbsync --config "$XDG_CONFIG_HOME/mbsyncrc" -a'
alias ty='ttytter -rc="$XDG_CONFIG_HOME"/ttytter/ttytterrc'

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
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
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

function 5v {
	if [[ -d "$HOME"/venvs/"$1" ]]; then
		source "$HOME"/venvs/"$1"/bin/activate
		printf "\x1b[38;5;2m==> 5venv ‘%s’ activated successfully.\x1b[0m\n" "$1"

	else
		printf "==> 5venv ‘%s’ not found\n" "$1"
		printf "==> Create? [yN]: "
		read yn

		if [[ "$yn" == 'y' || "$yn" == 'yes' ]]; then
			printf "==> Python version? [23]: "
			read venvver

			if [[ "$venvver" == '2' ]]; then
				virtualenv2 "$HOME"/venvs/"$1"
				if (( $? == 0 )); then
					print "\x1b[38;5;2m==> 5venv created successfully, installing basic requirements.\x1b[0m"
				else
					print "\x1b[38;5;1m==> Error: 5env creation failed. Exiting.\x1b[0m"
					return 1
				fi
				source "$HOME"/venvs/"$1"/bin/activate
				pip install -r "$HOME"/venvs/5_requirements.txt

			elif [[ "$venvver" == '3' ]]; then
				virtualenv3 "$HOME"/venvs/"$1"
				if (( $? == 0 )); then
					print "\x1b[38;5;2m==> 5venv created successfully, activating environment.\x1b[0m"
					print "==> Note that no requirements were installed due to version 3 was selected."
				else
					print "\x1b[38;5;1m==> Error: 5env creation failed. Exiting.\x1b[0m"
					return 1
				fi
				source "$HOME"/venvs/"$1"/bin/activate

			else
				printf "==> virtualenv for version ‘%s’ not found.\n" "$venvver"
				exit 1
			fi
		fi
	fi
}

function 5c {
	cd "$HOME"/projects/"$1"
}

function 5clone {
	if [[ -z "$1" ]]; then
		print "No repo name"
	fi

	(cd "$HOME"/projects
	git clone git@github.com:5m/"$1"
	shift
	cd -)

	pushd "$HOME"/projects/"$1"
	git config --local user.email johannes@5monkeys.se
}

alias 5ssh='TERM=xterm ssh'

tt() {
	if [[ -n "$@" ]]; then
		print "$@" | ts '[%Y-%m-%d %H:%M:%S]' >> "$HOME"/documents/timetracking
	fi
}
