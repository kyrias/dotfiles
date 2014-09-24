DEFAULT_COLOR="%{${fg[default]}%}"
function bold  { printf "%s%s%s" "%{%B%}" "$1" "%{%b%}" }
function red   { printf "%s%s%s" "%{${fg[red]}%}" "$1" "$DEFAULT_COLOR" }
function green { printf "%s%s%s" "%{${fg[green]}%}" "$1" "$DEFAULT_COLOR" }
function blue  { printf "%s%s%s" "%{${fg[blue]}%}" "$1" "$DEFAULT_COLOR" }
function cyan { printf "%s%s%s" "%{${fg[cyan]}%}" "$1" "$DEFAULT_COLOR" }
function magenta { printf "%s%s%s" "%{${fg[magenta]}%}" "$1" "$DEFAULT_COLOR" }
function yellow { printf "%s%s%s" "%{${fg[yellow]}%}" "$1" "$DEFAULT_COLOR" }
function black { printf "%s%s%s" "%{${fg[black]}%}" "$1" "$DEFAULT_COLOR" }
function white { printf "%s%s%s" "%{${fg[white]}%}" "$1" "$DEFAULT_COLOR" }
function prompt_user_color {
	(( UID )) && print -n red || print -n magenta
}

PROMPT="$(yellow "┌─[") $(yellow "$(bold %m)") \
$($(prompt_user_color) "$(bold %n)") \
$(blue "$(bold %~)") $(magenta $(bold '$branch'))$(yellow "]")
$(yellow "└─╼") "
