# this file should contain all aliases, or at least some very welcome an common ones

# list all Aliases
alias list="echo -e '\e[31m\e[1mNo.\tAlias\t\tCommand\e[0m';grep alias ~/.bashrc |cut -d' ' -f2- | sed 's/\=/\t\t/g' | nl -w 2"

# print all relevant directory info
alias la="ls -lah"

# print all relevant directory info + recursive
alias lr="ls -lahR"

# print security context
alias sec="ls -Z"

# Enable Aliases to be sudo’ed
alias sudo='sudo '

# verbose time command
alias time="/usr/bin/time -v"

# we handle command line file handling verbose and interactive
alias rm="rm -iv"
alias mv="mv -iv"
alias cp="cp -iv"