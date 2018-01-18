#! /bin/sh
function content() {
	cat $0
}
content
exit

##############################################################

# Prepend line number
ls | nl

# Who is logged in?
w

# Cat backwards (starting from the end)
tac $(find . -type f | head -1)

# random sort (don`t know how that is useful yet...)
sort -R $(find . -type f | tail -1)

# Keep program running after leaving SSH session
# If the program doesn't need any interaction
nohup <script.sh> &

# Run a command for a limited time
# timeout 10s ./script.sh
# Restart every 30 minutes
while true; do timeout 30m ./script.sh; done

# Flush swap partition
# If a program eats too much memory, the swap can get filled with the rest of the memory 
# and when you go back to normal, everything is slow. Just restart the swap partition to fix it
sudo swapoff -a
sudo swapon -a

# Create empty file of given size
fallocate -l 1G test.img

# get executable of a command
command -v uuidgen

# create a uuid
uuidgen

# execute command
command uuidgen

# get Codierung
echo $LANG

# List service and their open ports
netstat -tulpn

# Disk File Size
df

# Disk free human-readable and file system type
df -hT

# disk usage
#	-h 		human readable
#	-a		all
#	-c 		total
du -cah | grep total

# find biggest tile Files
find -name tirex | du -ah | sort -nr | head -30

# List all sh files (including subdirectories)
find . -type f -name "*.sh"

# List all CSS or HTML files:
find . -type f \( -name "*.css" -or -name "*.html" \)

# delete every single file, excluding directories, below the current working directory
find . ! -type d -delete
find . ! -type d -exec rm '{}'

# make executable, for current user
chmod u+x <file>

# group-own
chgrp 

# How to symlink a file
ln -s /path/to/file /path/to/symlink
ln -s /path/to/file-name /link-name

# Zipping / unzipping
# Create an archive
#	c	create archive
#	v	verbose
#	f	file name
#	--> NO COMPRESSION!	Add filter option with compoiression algorithm
#			z	gzip		<.tar.gz extension>
#			j	bzip2		<tar.bz2 extension>
tar cvf archive_name.tar dirname/

# Extracting (untar) an archive
#	x 	extract
tar xvf archive_name.tar

# Listing an archive (View the tar archive file content without extracting)
# 	t	list (--list tuts auch)
tar tvf file_name.tar

# Return information for a given file. 
# For example, you can print the size information of an image:
file <image.jpg>

# print the processId of a running program.
pidof systemd
-> will return 1 

# visualize process forks
pstree

# kill nginx by taking PID number and giving to kill command:
kill -USR2 $(pidof nginx)

# List contents of a directory in tree-like format. 
# option -d: show only directories
tree -d

# show directory structure 3 levels down (with file sizes and including hidden directories)
tree -LhaC 3

# list open file descriptors (-i flag for network interfaces)
lsof -i :8080

# list currently open Internet/UNIX sockets and related information
netstat | head -n20

# stream current disk, network, CPU activity & more
dstat -a

# find hostname for a remote IP address
nslookup 88.99.31.76

# trace system calls of a program (-e flag to filter for certain system calls)
strace -f -e <syscall> <cmd>

# print currently active processes
ps aux | head -n20

# make a server (check with netstat -tulpn)
nc -lk 8999 

# curl the server
curl localhost:8999