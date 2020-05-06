#########################################################################
#                                                                       #
#    Run `all` for setup/updates, `clean` to remove **only configs**    #
#                                                                       #
#########################################################################
.DEFAULT_GOAL := all
.PHONY: all
all:| brew install

#############################
#    Common config setup    #
#############################
empty_string  :=
space := $(empty_string) #
comma := ,

.PHONY: install clean
override define tool_config_targets
$(config_name) = $1
$(config_file) = $2
$(config_src) = $3
$(config_dest) = $4

.PHONY: $(config_name)
$(config_name): $(config_dest)/$(config_file)

$(config_dest)/$(config_file): $(config_src)/$(config_file)
	@if test -s $(config_dest)/$(config_file); then \
		echo Saved a backup of the old $(config_dest)/$(config_file) !; \
		mv $(config_dest)/$(config_file){,.backup-$(shell date '+%Y-%m-%d-%H:%M:%S')}; \
	fi
	@echo Attempting to symlink $(config_src)/$(config_file) to $(config_dest)/$(config_file)
	ln -s $(config_src)/$(config_file) $(config_dest)/$(config_file)

install: $(config_name)

.PHONY: $(config_name)_clean
$(config_name)_clean:
	mv $(config_dest)/$(config_file){,.backup-$(shell date '+%Y-%m-%d-%H:%M:%S')}; \

clean: $(config_name)_clean

endef

all_config_settings = \
	vim,init.vim,$(CURDIR),~/.config/nvim\
	coc_nvim,coc-settings.json,$(CURDIR),~/.config/nvim\
	minivim,.vimrc,$(CURDIR),~\
	zsh,.zshrc,$(CURDIR),~\
	alacritty,.alacritty.yml,$(CURDIR),~\
	tmux,.tmux.conf,$(CURDIR),~\
	gitconfig,.gitconfig,$(CURDIR),~\
	gitignore,.gitignore,$(CURDIR),~

$(foreach config_settings_commasep,\
	$(all_config_settings),\
	$(eval config_settings_spacesep = $(subst $(comma),$(space),$(config_settings_commasep))) \
	$(eval config_name = $(word 1, $(config_settings_spacesep))) \
	$(eval config_file = $(word 2, $(config_settings_spacesep))) \
	$(eval config_src = $(word 3, $(config_settings_spacesep))) \
	$(eval config_dest = $(word 4, $(config_settings_spacesep))) \
	$(eval $(call tool_config_targets,$(config_name),$(config_file),$(config_src),$(config_dest))))

#############################
#    Tmux plugin manager    #
#############################
.PHONY: tpm
~/.tmux/plugins/tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tpm: ~/.tmux/plugins/tpm
tmux: tpm

###############
#    Boxes    #
###############
.PHONY: boxes
~/boxes-config:
	cd ~ && curl -O https://raw.githubusercontent.com/ascii-boxes/boxes/master/boxes-config
boxes: ~/boxes-config brew
vim: boxes

##############
#    Brew    #
##############
brew: Brewfile.lock.json

Brewfile.lock.json: brew_exists Brewfile
	brew bundle install

brew_exists:
ifeq ($(shell command -v brew),)
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
endif

