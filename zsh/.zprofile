export PATH="$HOME"/.local/bin:"$PATH":"$HOME"/.gem/ruby/2.0.0/bin:$PLAN9/bin
export PLAN9=/usr/local/plan9

export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

export MPV_HOME="$XDG_CONFIG_HOME"/mpv
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc-2.0
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/XCompose

export ABSROOT="$HOME/build/abs"

export EDITOR=vim
# Set vimrc's location and source it on vim startup
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

export PAGER=less
export LESSHISTFILE=-

export LESSOPEN="|lesspipe.sh %s"
export LESSCOLORIZER=pygmentize

export GREP_OPTIONS=--color=auto
export LESS=-R

export BROWSER=firefox
export TERMINAL=termite

export SDL_AUDIODRIVER=pulse

export GTK_IM_MODULE=xim

export SUDO_PROMPT=$'\e[31mSUDO\e[m password for \e[34m%p\e[m: '

export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx "$HOME"/.config/X11/xinitrc
envoy -t gpg-agent
source <(envoy -p)
