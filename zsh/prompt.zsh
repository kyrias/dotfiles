function red
	printf "%s%s%s" "%F{red}" "$@" "%f"
function redbg
	printf "%s%s%s" "%K{red}" "$@" "%k"
function redbg_p
	printf "%s%s%s" "%K{red}" "$@" "%k"

function bluebg_p
	printf "%s%s%s" "%K{blue}" "$@" "%k%F{blue}%f"

function black
	printf "%s%s%s" "%F{black}" "$@" "%f"
function blackbg
	printf "%s%s%s" "%K{black}" "$@" "%k"

function white
	printf "%s%s%s" "%F{white}" "$@" "%f"
function whitebg
	printf "%s%s%s" "%K{white}" "$@" "%k"

if [[ $UID -ne 0 ]]; then
	PROMPT='$(blackbg " $(white %m) ")$(whitebg "$(black " %~") ")
%(?.$(bluebg_p "%B ^_^ %b").$(redbg_p "%B o_O %b")) '
else
	PROMPT='$(redbg " $(white %m) ")$(whitebg "$(red " %~") ")
%(?.$(bluebg_p "%B ^_^ %b").$(redbg_p "%B o_O %b")) '
fi
