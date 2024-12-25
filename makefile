install:
	stow --verbose --dotfiles --target=$$HOME --restow all/
install-t480:
	stow --verbose --dotfiles --target=$$HOME --restow */
delete:
	stow --verbose --dotfiles --target=$$HOME --delete */
