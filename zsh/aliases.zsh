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
alias pt='pstree --highlight-all --long --uid-changes'
alias pb='curl -F c=@- https://ptpb.pw/'

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

tt() {
	if [[ -n "$@" ]]; then
		print "$@" | ts '[%Y-%m-%d %H:%M:%S]' >> "$HOME"/documents/timetracking
	fi
}

function ix {
	curl -F 'f:1=<-' ix.io
}
