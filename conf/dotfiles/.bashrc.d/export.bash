#!/usr/bin/env bash

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M: ';
export HISTCONTROL='ignoreboth';

# nano is better
export EDITOR=/usr/bin/nano;

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# add an run-command file for python
export PYTHONSTARTUP="$HOME/.pythonrc"
