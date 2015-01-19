export PATH="$HOME"/.local/bin:"$HOME"/.gem/ruby/2.1.0/bin:"$PATH"

# Set XDG Basedir Spec paths
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

# Program homedir overrides
export MPV_HOME="$XDG_CONFIG_HOME"/mpv
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GALE_DIR="$XDG_CONFIG_HOME"/gale

# Config overrides
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc-2.0
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/XCompose
export XAUTHORITY="$XDG_RUNTIME_DIR"/xauthority
export ABSROOT="$HOME"/build/abs

export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/password-store

export EDITOR=vim
export VISUAL=vim
export VIMINIT='source $XDG_CONFIG_HOME/vim/vimrc'

export BROWSER=chromium
export TERMINAL=termite

export PAGER=less
export LESS=-R
export LESSHISTFILE="$XDG_CACHE_HOME"/lesshist

export SDL_AUDIODRIVER=pulse

export GTK_IM_MODULE=xim

export SUDO_PROMPT=$'\e[31mSUDO\e[m password for \e[34m%p\e[m: '

export SHORTHOST=$(hostname -s)

if [[ -f "$ZDOTDIR"/profile-"$SHORTHOST" ]]; then
	source "$ZDOTDIR"/profile-"$SHORTHOST"
fi

# LS_COLORS is now required for `ls` to use colors
source <(dircolors -b "$XDG_CONFIG_HOME"/dircolors)

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx "$XDG_CONFIG_HOME"/X11/xinitrc
fi
