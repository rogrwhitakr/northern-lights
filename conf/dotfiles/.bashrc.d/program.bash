
# systemd
alias timers="systemctl list-timers"
alias enabled='systemctl is-enabled "$@"'

# update the system
alias update="sudo dnf update -y"

# git
alias gits="ret=$(pwd) && cd ~/MyScripts && git status && cd $ret"
alias pull_nl='cd ~/MyScripts && git pull northern-lights'
alias push_nl='cd ~/MyScripts && git push northern-lights'

# ansible
# local vm status
# this is somewhat problematic as NO cheks take place beforehand....
alias up="ansible northernlights -m ping"