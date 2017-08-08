# .bashrc
# User specific Aliases and functions as ~/.bashrc is for interactive use
# When Bash starts as an interactive non-login shell, it reads and executes commands from ~/.bashrc. 

# Test for an interactive shell. There is no need to set anything past this point for scp and rcp, and it's important to refrain from outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

####################################### Exports ######################################

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

######################################## Alias ########################################

# list all Aliases
alias listalias="echo -e '\e[31m\e[1mNo.\tAlias\t\tCommand\e[0m';grep alias ~/.bashrc |cut -d' ' -f2- | sed 's/\=/\t\t/g' | nl -w 2"

# print all relevant directory info
alias la="ls -lah"

# print all relevant directory info + recursive
alias lr="ls -lahR"

# Enable Aliases to be sudo’ed
alias sudo='sudo '

# verbose time command
alias time="/usr/bin/time -v "

# test if there is connectivity
alias pingg='ping google.de -c 5ip'

# list timers, enabled
alias timers="systemctl list-timers"
alias enabled='systemctl is-enabled ""'

# update the system
alias update="sudo dnf update -y"

# lets try these first, maybe they are annoying
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# git
alias gits="git status"


###################################### Functions ######################################

# list all and only hidden files in directory
hidden() {
    
  if [ -z "$@" ]; then
    directory=`pwd`
  else 
    directory="$@"
  fi

ls -ld "$directory"/.*
}

# universal extract, stolen from github somewhere
function extract {  
 if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.lzma)      unlzma $1      ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x -ad $1 ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

# compress common compressed Filetypes
compress() {
 if [ -z "$1" ]; then
    echo "Usage: compress <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else 
  File=$1
  shift
  case "${File}" in
    (*.tar.bz2) tar cjf "${File}" "$@"  ;;
    (*.tar.gz)  tar czf "${File}" "$@"  ;;
    (*.tgz)     tar czf "${File}" "$@"  ;;
    (*.zip)     zip "${File}" "$@"      ;;
    (*.rar)     rar "${File}" "$@"      ;;
    (*)         echo "Filetype not recognized" ;;
  esac
}