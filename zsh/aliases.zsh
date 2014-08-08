##
# Aliases and functions
#

alias '...'='../..'

ls_options=('--almost-all' '--classify'  '--color=auto'
            '--human-readable' '--group-directories-first')
alias ls='ls "${ls_options[@]}"'
alias ll='ls "${ls_options[@]}" -l'

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
