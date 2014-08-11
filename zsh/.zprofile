export PATH="$HOME"/.local/bin:"$PATH"

export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

export MPV_HOME="$XDG_CONFIG_HOME"/mpv
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc-2.0
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/XCompose
export XAUTHORITY="$HOME"/.local/share/xorg/authority

export ABSROOT="$HOME"/build/abs

export PREFIX="$HOME"/.local

export EDITOR=vim
export VISUAL=vim
export VIMINIT='source $XDG_CONFIG_HOME/vim/vimrc'

export PAGER=less
export LESS=-R
export LESSHISTFILE="$XDG_CACHE_HOME"/lesshist
export LESSOPEN="|lesspipe.sh %s"
export LESSCOLORIZER=pygmentize

export GREP_OPTIONS=--color=auto

export BROWSER=firefox
export TERMINAL=termite

export SDL_AUDIODRIVER=pulse

export GTK_IM_MODULE=xim

export SUDO_PROMPT=$'\e[31mSUDO\e[m password for \e[34m%p\e[m: '

export HOSTNAME=$(hostname -s)
export FQDN=$(hostname -f)

# LS_COLORS is now required for `ls` to use colour
source <(dircolors -b "$XDG_CONFIG_HOME"/dircolors)

function {
	local envfile="$XDG_RUNTIME_DIR"/gpg-agent.env
	if [[ -e "$envfile" ]] && kill -0 $(cut -d':' -f2 <"$envfile") &>/dev/null; then
		source "$envfile"
	else
		source <(gpg-agent --daemon --write-env-file "$envfile")
		export GPG_AGENT_INFO
	fi
}

function {
	local envfile="$XDG_RUNTIME_DIR"/ssh-agent.env
	local pid=$(awk -F'[=;]' 'FNR == 2 {print $2}' "$envfile" 2>/dev/null)

	if [[ -n "$pid" ]] && kill -0 "$pid" &>/dev/null; then
		source "$envfile" >/dev/null
	else
		ssh-agent > "$envfile"
		source "$envfile" >/dev/null
	fi
}

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx "$XDG_CONFIG_HOME"/X11/xinitrc
fi
