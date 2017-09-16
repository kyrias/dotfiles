i3venv = "$(HOME)"/.local/share/i3/venv

all: install

$(i3venv):
	mkdir -p "$(i3venv)"
	python -m venv "$(i3venv)"
	"$(i3venv)"/bin/pip install --upgrade -e git+https://github.com/enkore/i3pystatus#egg=i3pystatus netifaces colour -e git+https://github.com/bastienleonard/pysensors#egg=pysensors

install: $(i3venv)
	-ln -sfn "$(PWD)/ssh" "$(HOME)/.ssh"
	-ln -sfn "$(PWD)/gnupg" "$(HOME)/.gnupg"
	-ln -sf "$(PWD)/zsh/zshenv" "$(HOME)/.zshenv"
	-mkdir -p "$(HOME)/.cache/zsh"
	-mkdir -p "$(HOME)/.local/share/nvim/backup"
	-ln -sf "$(PWD)/mailcap" "$(HOME)/.mailcap"
	-ln -sf "$(PWD)/msmtprc" "$(HOME)/.msmtprc"

~/misc/grawity/:
	-mkdir -p ~/misc/grawity

~/misc/grawity/code: ~/misc/grawity/
	-git clone https://github.com/grawity/code ~/misc/grawity/code

grawity-code: ~/misc/grawity/code
	-cd ~/misc/grawity/code; git pull
	-make -C ~/misc/grawity/code pklist

.PHONY: all install
