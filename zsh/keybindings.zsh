##
# Keybindings
#


# Make sure the terminal is in application mode when zle is active. Only then
# are the values from $terminfo valid.
zle-line-init() {
	printf '%s' "${terminfo[smkx]}"
	zle reset-prompt
}
zle-line-finish () {
	printf '%s' "${terminfo[rmkx]}"
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N edit-command-line


# Don't skip over / in e.g. paths
# <http://zshwiki.org/home/zle/bindkeys>
export WORDCHARS="${WORDCHARS:s#/#}"


# Shift-tab
bindkey $terminfo[kcbt] reverse-menu-complete

# Insert
bindkey $terminfo[kich1] overwrite-mode

# Delete
bindkey $terminfo[kdch1] delete-char

bindkey $terminfo[khome] beginning-of-line
bindkey $terminfo[kend] end-of-line

# Backspace (and <C-h>)
bindkey $terminfo[kbs] backward-delete-char

# Do history expansion on space
bindkey ' ' magic-space

bindkey '^H' backward-delete-char
bindkey '^[w' backward-kill-word

bindkey '^[f' forward-word
bindkey '^[b' backward-word

bindkey '^[r' redo
bindkey '^[u' undo

# Patterned history search with zsh expansion, globbing, etc.
bindkey '^R' history-incremental-pattern-search-backward

# Verify search result before accepting
bindkey -M isearch '^M' accept-search

# Misc
bindkey -M vicmd 'ga' what-cursor-position
