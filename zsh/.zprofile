export PATH="$HOME"/.local/bin:"$PATH"

# Set XDG Basedir Spec paths
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

# Program homedir overrides
export MPV_HOME="$XDG_CONFIG_HOME"/mpv
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg

# Config overrides
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc-2.0
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/XCompose
export ABSROOT="$HOME"/build/abs

export PREFIX="$HOME"/.local

export EDITOR=vim
export VISUAL=vim
export VIMINIT='source $XDG_CONFIG_HOME/vim/vimrc'

export BROWSER=firefox
export TERMINAL=termite

export PAGER=less
export LESS=-R
export LESSHISTFILE="$XDG_CACHE_HOME"/lesshist

export GREP_OPTIONS=--color=auto

export SDL_AUDIODRIVER=pulse

export GTK_IM_MODULE=xim

export SUDO_PROMPT=$'\e[31mSUDO\e[m password for \e[34m%p\e[m: '

export HOSTNAME=$(hostname -s)
export FQDN=$(hostname -f)

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/"$UID"/dbus/user_bus_socket

export XAUTHORITY="$XDG_RUNTIME_DIR"/xauthority

# LS_COLORS is now required for `ls` to use colour
source <(dircolors -b "$XDG_CONFIG_HOME"/dircolors)

[[ -f "$ZDOTDIR"/profile-"$(hostname -s)" ]] && \
    source "$ZDOTDIR"/profile-"$(hostname -s)"

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx "$XDG_CONFIG_HOME"/X11/xinitrc
fi
