function red
	printf "%s%s%s" "%F{red}" "$@" "%f"
function redbg
	printf "%s%s%s" "%K{red}" "$@" "%k"
function redbg_p
	printf "%s%s%s" "%K{red}" "$@" "%k$(red $RSEGF$RSEG)"

function bluebg_p
	printf "%s%s%s" "%K{blue}" "$@" "%k%F{blue}$RSEGF$RSEG%f"

function black
	printf "%s%s%s" "%F{black}" "$@" "%f"
function blackbg
	printf "%s%s%s" "%K{black}" "$@" "%k"

function white
	printf "%s%s%s" "%F{white}" "$@" "%f"
function whitebg
	printf "%s%s%s" "%K{white}" "$@" "%k"

function user_color {
	(( UID )) && print -n black || print -n red
}

RSEGF=""
RSEG=""
LSEGF=""
LSEG=""
BRNCH=""
PROMPT='$($(user_color)bg " $(white %m) ")$(whitebg "$($(user_color) "$RSEGF %~") ")$RSEGF
%(?.$(bluebg_p "%B ^_^ %b").$(redbg_p "%B o_O %b")) '
