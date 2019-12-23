all: vim fish
	cp .tmux.conf ~/

fish:
	mkdir -p ~/.config/fish
	cp config.fish ~/.config/fish

vim:
	cp init.vim ~/.config/nvim/
	cp coc-settings.json ~/.config/nvim/

minivim:
	cp minimal.vimrc ~/.vimrc
