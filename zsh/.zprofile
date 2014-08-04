export PATH="$HOME"/.local/bin:"$PATH"

export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

export MPV_HOME="$XDG_CONFIG_HOME"/mpv
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc-2.0
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/XCompose
export XAUTHORITY="$XDG_RUNTIME_DIR"/X11/authority

export ABSROOT="$HOME"/build/abs

export EDITOR=vim
export VISUAL=vim
# Set vimrc's location and source it on vim startup
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

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

# LS_COLORS is now required for `ls` to use colour
eval "$(dircolors -b ~/.config/dircolors)"

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx "$XDG_CONFIG_HOME"/X11/xinitrc
fi
