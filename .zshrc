      ############################
      ##         Env            ##
      ############################
export EDITOR=nvim
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

      ###############################
      ##         Antigen           ##
      ###############################
ANTIGEN_FILE=~/antigen.zsh
[ -f "$ANTIGEN_FILE" ] || curl -L git.io/antigen > $ANTIGEN_FILE
source $ANTIGEN_FILE

antigen use oh-my-zsh

# Zsh Syntax
antigen bundle zsh-users/zsh-syntax-highlighting

# Fish-like autosuggest
zmodload zsh/zpty # For 'completion' strategy
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
antigen bundle zsh-users/zsh-autosuggestions

# Theme
antigen bundle mafredri/zsh-async

export PURE_CMD_MAX_EXEC_TIME=1   # Don't run for more than a second
export PURE_GIT_PULL=0            # Don't pull
export PURE_GIT_UNTRACKED_DIRTY=1 # Check for untracked files
antigen bundle sindresorhus/pure
zstyle :prompt:pure:git:stash show yes # Show stash status

antigen apply

      ###############################
      ##         Aliases           ##
      ###############################

###########################
###### General cli ########
###########################
alias la='ls -la'
alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias back='cd -'
alias o='open'
alias rm='rm -v'
alias cp='cp -i'
alias cwd='pwd | tr -d "\r\n" | pbcopy' # copy working directory
alias foldersize="du -hs"
# Ranger -- open dir that I last visited
alias ranger='ranger --choosedir="$HOME/.rangerdir"; cd (cat $HOME/.rangerdir)'
alias rng='ranger'

###################
###### Vim ########
###################
alias vim='nvim'
alias v='vim'
alias vi='vim'

####################
###### Tmux ########
####################
alias ta='tmux attach-session'
alias tn='tmux new-session -s'
alias tk='tmux kill-session -t'
alias tl='tmux list-sessions'

###################
###### FZF ########
###################
 #fd --type f -hidden --follow --exclude .git | fzf
 ## Setting fd as the default source for fzf
#set -x FZF_DEFAULT_COMMAND fd --type f --hidden --follow --exclude .git
 ## To apply the command to CTRL-T as well
#set -x FZF_CTRL_T_COMMAND '$FZF_DEFAULT_COMMAND'

###################
###### Git ########
###################
alias gs='git s'
alias gd='git d'
alias gl='git l'
alias gp='git ap'
alias ga='git a'
alias gcv='git cv'
alias gcp='git cp'
alias gcm='git cm'
alias gco='git checkout'
alias gcom='git checkout master'

#############
## Configs ##
#############
alias zshrc='vim ~/.zshrc'
alias reload='source ~/.zshrc'
alias vimrc='vim ~/.config/nvim/init.vim'

###############
## Shortcuts ##
###############
alias wsp='cd ~/workspace/'
alias docs='cd ~/Documents/Dropbox/Documents'
alias dl='cd ~/Downloads/'

