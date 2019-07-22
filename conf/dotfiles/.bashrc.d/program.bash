
# systemd
alias timers="systemctl list-timers"
alias enabled='systemctl is-enabled "$@"'

# update the system
alias update="sudo dnf update -y"

# ansible
# local vm status
# this is somewhat problematic as NO cheks take place beforehand....
alias up="ansible northernlights -m ping"