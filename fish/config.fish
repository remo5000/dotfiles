      ################################
      ##         Settings           ##
      ################################

# Use vi keys instead of emacs
fish_vi_key_bindings

# iTerm2 color for top-bar
echo -e "\033]6;1;bg;red;brightness;010\a"
echo -e "\033]6;1;bg;green;brightness;010\a"
echo -e "\033]6;1;bg;blue;brightness;010\a"

# Fish shell color scheme
set dangerous_colors day

# Set editor
export EDITOR=nvim

# Fix for python working with pipenv. See https://github.com/pypa/pipenv/issues/187
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

      ###############################
      ##         Aliases           ##
      ###############################

###########################
###### General CLI ########
###########################
alias ls='ls -hp'
alias la='ls -la'
alias mv='mv -v'
alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias back='cd -'
# alias ~='cd ~'
alias o='open'
alias grep='grep -H -n'
alias rm='rm -v'
alias cp='cp -i'
alias mv='mv -i'
alias cwd='pwd | tr -d "\r\n" | pbcopy' #copy working directory
alias foldersize="du -hs"
alias rng='ranger'

###################
###### vim ########
###################
alias vim='nvim'
# Used for vimtex #
# alias vim='vim --servername VIM'
alias v='vim'
alias vi='vim'

###################
###### Git ########
###################
alias gs='git s'
alias ga='git a'
alias gc='git cv'

############
## Config ##
############
alias fishconfig='vim ~/.config/fish/config.fish'
alias reload='source ~/.config/fish/config.fish'
alias taskrc='vim ~/.taskrc'
alias vimrc='vim ~/.vimrc'

###############
## Shortcuts ##
###############
alias wsp='cd ~/workspace/'
alias docs='cd ~/Documents/'
alias dl='cd ~/Downloads/'
alias fnt='yarn format; and yarn test'

##################
## Taskwarrior  ##
##################
alias t='task'
alias ts='task start'
alias tst='task stop'
alias tt='task due:today'
alias t+='task add'
alias tm='task modify'
alias te='task edit'
alias td='task done'
alias tw='task waiting'
alias tmin='task minimal'
alias tsch='task schedule'

#############
## Watson  ##
#############
alias ws='watson start'
alias wst='watson start'
alias wstat='watson status'
alias we='watson edit'

      ############################
      ##         PATH           ##
      ############################

set -gx PATH $PATH /Users/vigneshshankar/Library/Python/3.6/bin
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x LANGUAGE en_US.UTF-8
