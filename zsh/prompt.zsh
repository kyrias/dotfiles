bg[light_pink]='%K{001}'
bg[light_red]='%K{196}'
bg[red]='%K{88}'
bg[dark_red]='%K{52}'

fg[light_pink]='%F{001}'
fg[light_red]='%F{196}'
fg[red]='%F{88}'
fg[dark_red]='%F{52}'


bg[light_gold]='%K{136}'
bg[gold]='%K{139}'
bg[dark_gold]='%K{94}'

fg[light_gold]='%F{136}'
fg[gold]='%F{139}'
fg[dark_gold]='%F{94}'


bg[light_blue]='%K{blue}'
bg[blue]='%K{21}'

fg[light_blue]='%F{blue}'
fg[blue]='%F{21}'


if (( UID == 0 )); then
	PROMPT='$bg[light_red] $fg[white]%m%f %k$bg[white]$fg[light_red] %~ %f%k
$bg[light_blue]%B ^_^ %b%k '

else
	case $SHORTHOST in
	"theos")
		PROMPT='$bg[light_pink] $fg[white]%m%f %k$bg[white]$fg[light_pink] %~ %f%k
$bg[light_blue]%B ^_^ %b %k'
		;;

	"lucifer")
		PROMPT='$bg[dark_gold] $fg[white]%m%f %k$bg[white]$fg[dark_gold] %~ %f%k
$bg[light_blue]%B ^_^ %b %k'
		;;

	*)
		PROMPT='$bg[black] $fg[white]%m%f %k$bg[white]$fg[black] %~ %f%k
$bg[light_blue]%B ^_^ %b %k'
		;;

	esac
fi
