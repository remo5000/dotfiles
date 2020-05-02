# STRIPE
source (rbenv init -|psub)
source ~/stripe/space-commander/bin/sc-env-activate.fish
functions -e fish_right_prompt
set -U fish_user_paths "$HOME/.rbenv/shims" $fish_user_paths
set -U fish_user_paths "$HOME/.rbenv/bin" $fish_user_paths
set -U fish_user_paths "$HOME/stripe/password-vault/bin" $fish_user_paths
set -U fish_user_paths "$HOME/stripe/space-commander/bin" $fish_user_paths
set -U fish_user_paths "$HOME/stripe/henson/bin" $fish_user_paths

      ################################
      ##         Settings           ##
      ################################

# Use vi keys instead of emacs
set -U fish_key_bindings fish_vi_key_bindings
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

# Fish shell color scheme
set dangerous_colors night
set SHELL /usr/local/bin/bash
# editor
set -U EDITOR nvim
set -U MYVIMRC '~/.config/nvim/init.vim'

      ###########################################
      ##           CLI Program Configs         ##
      ###########################################

# ASDF
source ~/.asdf/asdf.fish


      ###############################
      ##         Aliases           ##
      ###############################

###########################
###### General CLI ########
###########################
alias la='ls -la'
alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias back='cd -'
alias o='open'
# alias grep='grep -H -n'
alias rm='rm -v'
alias cp='cp -i'
alias cwd='pwd | tr -d "\r\n" | pbcopy' #copy working directory
alias foldersize="du -hs"
alias rng='ranger'

###################
###### vim ########
###################
alias vim='nvim'
alias v='vim'
alias vi='vim'

###################
###### FZF ########
###################
# fd --type f -hidden --follow --exclude .git | fzf
# # Setting fd as the default source for fzf
set -x FZF_DEFAULT_COMMAND fd --type f --hidden --follow --exclude .git
# # To apply the command to CTRL-T as well
set -x FZF_CTRL_T_COMMAND '$FZF_DEFAULT_COMMAND'
# Use the bindings
fzf_key_bindings

###################
###### Git ########
###################
alias gs='git s'
alias ga='git a'
alias gap='git add --patch'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gcom='git checkout master'

############
## Config ##
############
alias fishconfig='vim ~/.config/fish/config.fish'
alias reload='source ~/.config/fish/config.fish'
alias vimrc='vim ~/.config/nvim/init.vim'

###############
## Shortcuts ##
###############
alias wsp='cd ~/stripe/'
alias docs='cd ~/Documents/Dropbox/Documents'
alias dl='cd ~/Downloads/'

# opam configuration
alias op='opam'
source /Users/vigneshshankar/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
