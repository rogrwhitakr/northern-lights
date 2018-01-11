#! /bin/sh

#	for all users:
#	-	place into
#		/usr/share/applications
#
#	for own user:
#	-	place into
#		~/.local/share/applications


# count files in current directory
ls -1 /usr/share/applications/*.desktop | wc -l

# exclude symbolic links
ls -1 /usr/share/applications/*.desktop | grep -v ^l | wc -l