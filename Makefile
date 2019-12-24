all: vim fish karabiner
	cp .tmux.conf ~/

fish:
	mkdir -p ~/.config/fish/
	cp config.fish ~/.config/fish/

vim:
	cp init.vim ~/.config/nvim/
	cp coc-settings.json ~/.config/nvim/

minivim:
	cp minimal.vimrc ~/.vimrc

karabiner:
	cp custom-capslock.json ~/.config/karabiner/assets/complex_modifications/
