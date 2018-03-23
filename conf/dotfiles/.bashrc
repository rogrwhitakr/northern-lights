# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source user alias definitions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Source user function definitions
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

####################################### Export ########################################

# make history bigger
export HISTSIZE=10000
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M: '

# nano is better
export EDITOR=/usr/bin/nano

######################################## Alias ########################################

# test if there is connectivity
alias pingg='ping google.de -c 5ip'

# list timers, enabled
alias timers="systemctl list-timers"
alias enabled='systemctl is-enabled "$@"'

# update the system
alias update="sudo dnf update -y"

# git
alias gits="ret=$(pwd) && cd ~/MyScripts && git status && cd $ret"
alias pull_nl='cd ~/MyScripts && git pull northern-lights'
alias push_nl='cd ~/MyScripts && git push northern-lights'
alias commit='cd ~/MyScripts && sleep 1 && git add . && git commit'

###################################### Functions ######################################

# moved to .bash_functions

###################################### Powerline ######################################

if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi