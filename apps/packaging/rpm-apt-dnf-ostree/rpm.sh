#! /usr/bin/env bash

trap "rm -f *-rpm.xml" EXIT INT TERM

# rpm
rpm -q ansible
rpm --query ansible

# verbose
rpm -qi ansible

# in conjuction with query i means "info", otherwise "install"
rpm --query --info ansible

# this outputs the whole tree with all dependencies
rpm --query --xml ansible > ansible-rpm.xml 
rpm -q --xml youtube-dl > yt-dl-rpm.xml

# one can query bits of this, like the changelog
rpm -q --changelog youtube-dl 

# list files (--list)
rpm -ql youtube-dl 

# list dependencies (--requires)
rpm -qR youtube-dl 

# list provides
rpm --query --provides ansible

# query a LOCAL file (needs dowloading)
rpm --query --requires --package ansible-2.7.8-1.fc28.ans.noarch.rpm

# other search options are --recommends, --conflicts, ....

# install a local rpm file
rpm --install <rpm-file>

read 