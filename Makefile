all: vim tmux zsh

TMUX_CONF=.tmux.conf
tmux:
	ln -s $(CURDIR)/$(TMUX_CONF) ~/

ZSHRC=.zshrc
zsh:
	ln -s $(CURDIR)/$(ZSHRC) ~/

INIT_VIM=init.vim
COC_SETTINGS_JSON=coc-settings.json
NVIM_CONFIG_LOC=~/.config/nvim
vim:
	ln -s $(CURDIR)/$(INIT_VIM) $(NVIM_CONFIG_LOC)/
	ln -s $(CURDIR)/$(COC_SETTINGS_JSON) $(NVIM_CONFIG_LOC)/

minivim:
	ln -s ./minimal.vimrc ~/.vimrc

clean:
	# These should be symlinks anyway, but we rename it just in case it's a real file
	test ! -s ~/$(TMUX_CONF) || mv ~/$(TMUX_CONF) ~/$(TMUX_CONF).old
	test ! -s ~/$(ZSHRC) || mv ~/$(ZSHRC) ~/$(ZSHRC).old
	test ! -s $(NVIM_CONFIG_LOC)/$(INIT_VIM) || mv $(NVIM_CONFIG_LOC)/$(INIT_VIM) $(NVIM_CONFIG_LOC)/$(INIT_VIM).old
	test ! -s $(NVIM_CONFIG_LOC)/$(COC_SETTINGS_JSON) || mv $(NVIM_CONFIG_LOC)/$(COC_SETTINGS_JSON) $(NVIM_CONFIG_LOC)/$(COC_SETTINGS_JSON).old
