#! /bin/sh

#this works best with ssh keys configured

# copy from machine to machine
scp <from> <to>

# copy from local to remote
scp <file> <user>@<machine>:~/<(future)remote-file>

# copy from remote to local
scp <user>@<machine>:~/<remote-file> <(future)local-file>

# copy from remote to remote
scp <user>@<machine>:~/<remote-file> <user>@<machine>:~/<(future)local-file>

# copy bulk / whole directories
scp -r <user>@<machine>:~/<remote-dir> <(future)local-dir>

# copy all jpgs from local to remote-dir
scp *.jpg <user>@<machine>:~/images/jpg

# copy all gifs from remote to local dir
scp -r <machine>:~/gifs/*.gif ~/gif