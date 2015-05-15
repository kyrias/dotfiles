install:
	-ln -sf "$(PWD)/zsh/.zshenv" "$(HOME)/.zshenv"
	-ln -sfn "$(PWD)/ssh" "$(HOME)/.ssh"
	-ln -sfn "$(PWD)/gnupg" "$(HOME)/.gnupg"
