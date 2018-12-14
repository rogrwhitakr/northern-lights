#!/usr/bin/env bash

alias list="echo -e '\e[31m\e[1mNo.\tAlias\t\tCommand\e[0m';grep alias ~/.bashrc.d/*.bash |cut -d' ' -f2- | sed 's/\=/\t\t\t/g' | nl -w 2"
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'" # all functions
alias paths='echo -e ${PATH//:/\\n}'                             # all on path
alias la="ls -lah"                                               # print all relevant directory info
alias lr="ls -lahR"                                              # print all relevant directory info + recursive
alias ld="ls -lah --print-directories-first"                     # print all sorted
alias sec="ls -Z"                                                # print security context
alias sudo='sudo '                                               # Enable Aliases to be sudo’ed
alias reload="source ~/.bash_profile"                            # reload profile
alias time="/usr/bin/time -v"                                    # verbose time command

# we handle command line file handling verbose and interactive
alias rm="rm -iv"
alias mv="mv -iv"
alias cp="cp -iv"

# some addititons to getting around
alias -- -="cd -"                                                # Go to previous dir with -
alias cd.='cd $(readlink -f .)'                                  # Go to real dir (i.e. if current dir is linked)

# tree views
alias tree="tree -A"                                             # show all
alias treed="tree -d"                                            # show only dirs
alias tree1="tree -d -L 1"                                       # show only dirs, 1 level down
alias tree2="tree -d -L 2"                                       # show only dirs, 2 levels down

# network things
alias extip="dig +short myip.opendns.com @resolver1.opendns.com" # get external Ip

# battery status
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E --color=never "state|to\ full|percentage"'

