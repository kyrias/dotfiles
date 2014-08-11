##
# Keybindings
#


# Make sure the terminal is in application mode when zle is active. Only then
# are the values from $terminfo valid.
function zle-line-init () {
	printf '%s' "${terminfo[smkx]}"
}
function zle-line-finish () {
	printf '%s' "${terminfo[rmkx]}"
}
zle -N zle-line-init
zle -N zle-line-finish

bindkey -v

# Shift-tab
bindkey $terminfo[kcbt] reverse-menu-complete

# Delete
bindkey -M vicmd $terminfo[kdch1] vi-delete-char
bindkey          $terminfo[kdch1] delete-char

# Insert
bindkey -M vicmd $terminfo[kich1] vi-insert
bindkey          $terminfo[kich1] overwrite-mode

# End
bindkey -M vicmd $terminfo[kend] vi-end-of-line
bindkey          $terminfo[kend] vi-end-of-line

# Backspace (and <C-h>)
bindkey -M vicmd $terminfo[kbs] backward-char
bindkey          $terminfo[kbs] backward-delete-char

# Page up (and <C-b> in vicmd)
bindkey -M vicmd $terminfo[kpp] beginning-of-buffer-or-history
bindkey          $terminfo[kpp] beginning-of-buffer-or-history

bindkey -M vicmd '^B' beginning-of-buffer-or-history

# Page down (and <C-f> in vicmd)
bindkey -M vicmd $terminfo[knp] end-of-buffer-or-history
bindkey          $terminfo[knp] end-of-buffer-or-history

# Do history expansion on space
bindkey ' ' magic-space
#
# Use M-w for small words
bindkey '^[w' backward-kill-word
bindkey '^W' vi-backward-kill-word

bindkey -M vicmd '^H' backward-char
bindkey          '^H' backward-delete-char

# h and l whichwrap
bindkey -M vicmd 'h' backward-char
bindkey -M vicmd 'l' forward-char

# Incremental undo and redo
bindkey -M vicmd '^R' redo
bindkey -M vicmd 'u' undo

# Misc
bindkey -M vicmd 'ga' what-cursor-position

# Open in editor
bindkey -M vicmd 'v' edit-command-line

# History search
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# Patterned history search with zsh expansion, globbing, etc.
bindkey -M vicmd '^R' history-incremental-pattern-search-backward
bindkey          '^R' history-incremental-pattern-search-backward

# Verify search result before accepting
bindkey -M isearch '^M' accept-search
