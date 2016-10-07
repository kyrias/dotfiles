install:
	-ln -sf "$(PWD)/zsh/.zshenv" "$(HOME)/.zshenv"
	-ln -sfn "$(PWD)/ssh" "$(HOME)/.ssh"
	-ln -sfn "$(PWD)/gnupg" "$(HOME)/.gnupg"

~/misc/grawity/:
	-mkdir -p ~/misc/grawity

~/misc/grawity/code: ~/misc/grawity/
	-git clone https://github.com/grawity/code ~/misc/grawity/code

grawity-code: ~/misc/grawity/code
	-cd ~/misc/grawity/code; git pull
	-make -C ~/misc/grawity/code pklist
