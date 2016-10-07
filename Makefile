install:
	-ln -sf "$(PWD)/zsh/.zshenv" "$(HOME)/.zshenv"
	-ln -sfn "$(PWD)/ssh" "$(HOME)/.ssh"
	-ln -sfn "$(PWD)/gnupg" "$(HOME)/.gnupg"

grawity-code:
	-mkdir -p "$(HOME)"/misc/grawity
	-git clone https://github.com/grawity/code "$(HOME)"/misc/grawity/code
	-make -C code/ pklist
