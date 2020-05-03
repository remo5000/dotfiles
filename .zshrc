      ############################
      ##         zsh            ##
      ############################
export EDITOR=nvim

      ############################
      ##         brew           ##
      ############################
# Use this to initialze a machine -- it's too slow to use everytime
SHOULD_INSTALL_BREW_PACKAGES=false
BREW_PACKAGES=(fzf nvim)
if $SHOULD_INSTALL_BREW_PACKAGES; then
  brew update
  for package in $BREW_PACKAGES;
  do
    brew list $package || brew install $package
  done
fi

      ###############################
      ##         antigen           ##
      ###############################
ANTIGEN_FILE=~/antigen.zsh
[ -f "$ANTIGEN_FILE" ] || curl -L git.io/antigen > $ANTIGEN_FILE
source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle command-not-found

antigen theme evan

antigen apply

      ###############################
      ##         aliases           ##
      ###############################

###########################
###### general cli ########
###########################
alias la='ls -la'
alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias back='cd -'
alias o='open'
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
###### fzf ########
###################
 #fd --type f -hidden --follow --exclude .git | fzf
 ## Setting fd as the default source for fzf
#set -x FZF_DEFAULT_COMMAND fd --type f --hidden --follow --exclude .git
 ## To apply the command to CTRL-T as well
#set -x FZF_CTRL_T_COMMAND '$FZF_DEFAULT_COMMAND'

###################
###### git ########
###################
alias gs='git s'
alias ga='git a'
alias gap='git add --patch'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gcom='git checkout master'

############
## config ##
############
alias zshrc='vim ~/.zshrc'
alias reload='source ~/.zshrc'
alias vimrc='vim ~/.config/nvim/init.vim'

###############
## shortcuts ##
###############
alias wsp='cd ~/workspace/'
alias docs='cd ~/Documents/Dropbox/Documents'
alias dl='cd ~/Downloads/'
