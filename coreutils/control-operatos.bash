#! /usr/bin/env bash

a(){
    echo -e "\n[---------------------------]"
}

# Run Commands Sequentially
# next command executes regardless of the exit status of the previous command
whoami; a;cat /etc/rel; a;uptime;a

# run command assynchronally -> works in console directly script no
whoami & find / -name epel 2>/dev/null & cat /etc/*-release & uptime &

# AND
whoami && cat /etc/*-release

# OR
false || whoami