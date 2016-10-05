# Red
bg[light_pink]='%K{001}'
bg[light_red]='%K{196}'
bg[red]='%K{88}'
bg[dark_red]='%K{52}'

fg[light_pink]='%F{001}'
fg[light_red]='%F{196}'
fg[red]='%F{88}'
fg[dark_red]='%F{52}'


# Yellow
bg[light_gold]='%K{136}'
bg[gold]='%K{139}'
bg[dark_gold]='%K{94}'

fg[light_gold]='%F{136}'
fg[gold]='%F{139}'
fg[dark_gold]='%F{94}'


# Blue
bg[light_blue]='%K{blue}'
bg[blue]='%K{21}'

fg[light_blue]='%F{blue}'
fg[blue]='%F{21}'


# Green
bg[dark_green]='%K{64}'

function virtualenv_prompt {
	if [[ -n "$VIRTUAL_ENV" ]]; then
		print "$bg[light_blue]$fg[white] $(basename $VIRTUAL_ENV) %f%k"
	fi
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
	"$bg[light_pink] $fg[white]%b%f (%a) %k"

zstyle ':vcs_info:*' formats       \
    "$bg[light_pink] $fg[white]%b%f %k"

zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

function vcs_info_prompt {
  vcs_info
  if [[ -n "$vcs_info_msg_0_" ]]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{%f%}$del"
  fi
}

if (( UID == 0 )); then
	PROMPT='$bg[light_red] $fg[white]%m%f %k$bg[white]$fg[light_red] %~ %f%k$(virtualenv_prompt)
$bg[light_blue] λ %k '

else
	case $SHORTHOST in
	"theos")
		PROMPT='$bg[light_pink] $fg[white]%m%f %k$bg[white]$fg[light_pink] %~ %f%k$(virtualenv_prompt)
$bg[light_blue] λ %k '
		;;

	"lucifer")
		PROMPT='$bg[dark_gold] $fg[white]%m%f %k$bg[white]$fg[dark_gold] %~ %f%k$(virtualenv_prompt)
$bg[light_blue] λ %k '
		;;

	"nymeria")
		PROMPT='$bg[dark_green] $fg[white]%m%f %k$bg[white]$fg[dark_gold] %~ %f%k$(virtualenv_prompt)
$bg[light_blue] λ %k '
		;;

	*)
		PROMPT='$bg[black] $fg[white]%m%f %k$bg[white]$fg[black] %~ %f%k$(virtualenv_prompt)$(vcs_info_prompt)
$bg[light_blue] λ %k '
		;;

	esac
fi
