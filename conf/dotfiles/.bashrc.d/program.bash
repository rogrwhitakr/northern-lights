
# systemd
alias timers="systemctl list-timers"
alias enabled='systemctl is-enabled "$@"'

# update the system
alias update="sudo dnf update -y"

# ansible
# local vm status
# this is somewhat problematic as NO cheks take place beforehand....
alias up="ansible northernlights -m ping"

###################################### Powerline ######################################

if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi