      ################################
      ##         Settings           ##
      ################################

# Use emacs bindings for shell
set -U fish_key_bindings fish_default_key_bindings

# Fish shell color scheme
#
set SHELL /bin/bash

# Set editor
set EDITOR nvim

# Set lang
set LANGUAGE en_US.UTF-8
set LANG en_US.UTF-8
set LC_ALL en_US.UTF-8

# Opam
set -gx PATH /Users/vigneshshankar/.opam/4.10.0/bin $PATH

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
alias grep='grep -H -n'
alias rm='rm -v'
alias cp='cp -i'
alias cwd='pwd | tr -d "\r\n" | pbcopy' #copy working directory
alias foldersize="du -hs"
# Ranger -- open dir that I last visited
alias ranger='ranger --choosedir="$HOME/.rangerdir"; cd (cat $HOME/.rangerdir)'
alias rng='ranger'

###################
###### vim ########
###################
alias vim='nvim'
alias vi='vim'
alias v='vim'

###################
###### Git ########
###################
alias gs='git status'
alias ga='git add'
alias gap='git add --patch'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdl='gd ~HEAD HEAD'
alias gl='git lg'
alias gc='git commit --verbose'
alias gcv='git commit --verbose' # Legacy
alias gcp='git commit --patch --verbose'
alias gcap='git commit --amend --patch --verbose'
alias gca='git commit --amend --verbose'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcom='git checkout master'
alias gfo='git fetch origin'
alias gfom='git fetch origin master'
alias ghi='gh issue list --assignee remo5000 | fzf | awk \'{print $1;}\' | xargs -I% gh issue view %'

####################
###### Tmux ########
####################
alias ta='tmux attach-session -t'
alias tn='tmux new-session -s'
alias tk='tmux kill-session -t'
alias tl='tmux list-sessions'

#############
## Configs ##
#############
alias fishconfig='vim ~/.config/fish/config.fish'
alias reload='source ~/.config/fish/config.fish'
alias taskrc='vim ~/.taskrc'
alias vimrc='vim ~/.vimrc'

###############
## Shortcuts ##
###############
alias wsp='cd ~/workspace/'
alias docs='cd ~/Documents/Dropbox/Documents'
alias dl='cd ~/Downloads/'

# # opam configuration
# alias op='opam'
# source /Users/vigneshshankar/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
