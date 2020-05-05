.DEFAULT_GOAL := install

register_tool = $(foreach type, \
								install clean, \
								$(eval tools_$(type) += $(1)_$(type)))
register_varibales = $(foreach variable_declaration, \
										 $2, \
										 $(eval $1_install: $(variable_declaration)) \
										 $(eval $1_clean: $(variable_declaration)))
reg = $(foreach function, \
				register_tool register_varibales, \
				$(call $(function), $1, $2))

$(call reg, vim,        config_file=init.vim           config_src=$(CURDIR)  config_dest=~/.config/nvim)
$(call reg, coc_nvim,   config_file=coc-settings.json  config_src=$(CURDIR)  config_dest=~/.config/nvim)
$(call reg, minivim,    config_file=.vimrc             config_src=$(CURDIR)  config_dest=~)
$(call reg, zsh,        config_file=zshrc              config_src=$(CURDIR)  config_dest=~)
$(call reg, alacritty,  config_file=.alacritty.yml     config_src=$(CURDIR)  config_dest=~)
$(call reg, tmux,       config_file=.tmux.conf         config_src=$(CURDIR)  config_dest=~)

# Tmux package manager
tpm_install:
	test -d ~/.tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux_install: tpm_install

# Common install instructions for configs
install: $(tools_install)
clean:   $(tools_clean)

$(tools_install):
	@echo "Installing $(patsubst %_install,%, $@) config..."
	ln -s $(config_src)/$(config_file) $(config_dest) || echo Please run 'make clean'

$(tools_clean):
	@echo "Makng backup of $(patsubst %_clean,%, $@) config..."
	test ! -s $(config_dest)/$(config_file) || mv $(config_dest)/$(config_file){,.old}
