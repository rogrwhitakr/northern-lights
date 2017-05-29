# bin/sh

if [ -f ~/.bash_profile ]; then
	rm -f ~/.bash_profile
	touch ~/.bash_profile
	chmod 644 ~/.bash_profile
fi

tee >> /dev/null ~/.bash_profile << EOF
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

# colors

RED='\033[0;31m'
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset
EOF

if [ ! -f ~/.bashrc ]; then
	touch  ~/.bashrc
fi

tee >> /dev/null ~/.bashrc << EOF
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions as ~/.bashrc is for interactive use
# When Bash starts as an interactive non-login shell, it reads and executes commands from ~/.bashrc. 
# should contain aliases, since they need to be defined in every shell as they're not inherited from the parent shell.

# aliases and functions

hidden() {
		
	if [ -z "$@" ]; then
		directory=`pwd`
	else 
		directory="$@"
	fi

ls -d "$directory"/.*
}

# git

alias pull_nl="cd ~/MyScripts && sleep 1 && git pull https://github.com/rogrwhitakr/northern-lights"
alias push_nl="cd ~/MyScripts && sleep 1 && git push https://github.com/rogrwhitakr/northern-lights master"


echo -e "${RED}functions and aliases${NOC}"
echo -e "${NOC}	timers
	enabled
	pull_nl
	push_nl\n${NOC}"
EOF