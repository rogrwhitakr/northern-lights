# .bashrc
start="$(date +%s)"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

after_global="$(date +%s)"

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

after_init="$(date +%s)"
# User specific aliases and functions

# git
if [ -f ~/northern-lights/apps/git/git-bashrc-shortcuts.bash ]; then
 .  ~/northern-lights/apps/git/git-bashrc-shortcuts.bash
fi

# programs
if [ -f ~/northern-lights/conf/dotfiles/.bashrc.d/program.bash ]; then
  .  ~/northern-lights/conf/dotfiles/.bashrc.d/program.bash

fi
# export
if [ -f ~/northern-lights/conf/dotfiles/.bashrc.d/export.bash ]; then
  .  ~/northern-lights/conf/dotfiles/.bashrc.d/export.bash
fi

# alias
if [ -f ~/northern-lights/conf/dotfiles/.bashrc.d/function.bash ]; then
  .  ~/northern-lights/conf/dotfiles/.bashrc.d/function.bash
fi

# alias
if [ -f ~/northern-lights/conf/dotfiles/.bashrc.d/alias.bash ]; then
  .  ~/northern-lights/conf/dotfiles/.bashrc.d/alias.bash
fi

# more alias
if [ -f ~/northern-lights/conf/dotfiles/.bashrc.d/alias-flatpak.bash ]; then
  .  ~/northern-lights/conf/dotfiles/.bashrc.d/alias-flatpak.bash
fi

after_northern_lights="$(date +%s)"

# virsh nano editor
export EDITOR=/usr/bin/nano

after_completed="$(date +%s)"

# time it all
end="$(date +%s)"
runtime=$((end-start))
echo "script load execution took "${runtime}" seconds?"
echo "global load took "$((after_global - start))" seconds"
echo "init load took "$((after_init - start))" seconds"
echo "Northern-lights load took "$((after_northern_lights - start))" seconds"
echo "completed load took "$((after_completed - start))" seconds"
echo "start: "${start}", end: "${end}""
