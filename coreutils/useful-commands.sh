#! /bin/sh


### functions

function line() {
	echo [--------------------------------------------------------------------------------------------------------------]
}

print_red() {
	if [[ -z "$@" ]]; then
		echo "print_red(): no args set"
	fi	  	
	RED='\033[0;31m'
	NOC='\033[0m'
	echo -e ${RED}"$@"${NOC}
}

print_noc() {
	if [[ -z "$@" ]]; then
		echo "print_red(): no args set"
	fi	  	
	NOC='\033[0m'
	echo -e ${NOC}"$@"${NOC}
}

print_blue() {
	if [[ -z "$@" ]]; then
		echo "print_red(): no args set"
	fi	  	
	NOC='\033[0m'
	BLUE='\e[34m'
	echo -e ${BLUE}"$@"${NOC}
}
### variables

RED='\033[0;31m'
NOC='\033[0m' 	

### exec
line
print_red get executable of a command
print_blue command -v \$command
print_noc example command: uuidgen, creates a uuid
cmd=uuidgen
command -v $cmd
line
print_red execute command
print_blue command \$command
print_noc example command: uuidgen, creates a uuid
cmd=uuidgen
command $cmd
line
echo -e "${RED}#Finde Codierung${NOC}"
echo -e "${NOC}#	command:echo \$LANG${NOC}"
echo -e "${NOC}#	echo $LANG${NOC}"

line
echo -e "${RED}#List service and their open ports${NOC}"
echo -e "${NOC}#	netstat -tulpn${NOC}"
echo -e "${NOC}#	`netstat -tulpn`${NOC}"

line
echo -e "${RED}#get Virtual Network manager in LINUX${NOC}"
echo -e "${NOC}#	cd /usr/lib/vmware/bin
#	ln -s /usr/lib/vmware/bin/appLoader vmware-netcfg
#	ln -s /usr/lib/vmware/bin/vmware-netcfg /usr/bin/vmware-netcfg\n#${NOC}"

line
echo -e "${RED}#Disk File Size${NOC}"
echo -e "${NOC}#	df${NOC}"

line
echo -e "${RED}#disk usage ${NOC}"
echo -e "${NOC}#	du -cah | grep total
#	-h 		human readable
#	-a		all
#	-c 		total${NOC}"

line
echo -e "${RED}#find biggest tile Files${NOC}"
echo -e "${NOC}#	find -name tirex | du -ah | sort -nr | head -30${NOC}"

line
echo -e "${RED}#delete every single file, excluding directories, below the current working directory${NOC}"
echo -e "${NOC}#	find . ! -type d -delete
#	find . ! -type d -exec rm '{}' \;${NOC}"

line
echo -e "${RED}#Dateirechte in LINUX${NOC}"
echo -e "${NOC}#	--> Grundsätzlich kann man bei Linux die Dateirechte numerisch (755, 777) oder symbolisch (r, w, x) vergeben.
#	--> z.B.: 
#		--> drwxr-xr-x
#	
#	--> Rechte setzen mit chmod
#	--> 	Lesen = 4 
#		Schreiben = 2
#		Ausführen = 1
#			-->	User-Group-Other
#			--> u-g-o
#			--> chmod 755 <dateiname>${NOC}
#			--> chmod 755 httpd.conf${NOC}"

line
echo -e "${RED}#How to symlink a file${NOC}"
echo -e "${NOC}#	ln -s /path/to/file /path/to/symlink${NOC}"

line
echo -e "${RED}# Zipping / unzipping${NOC}"
echo -e "${NOC}#	tar command is the primary archiving utility
#	-->	Creating an archive${NOC}"

line
echo -e "${RED}tar cvf archive_name.tar dirname/${NOC}"
echo -e "${NOC}#	c	create archive
#	v	verbose
#	f	file name
#	--> NO COMPRESSION!	Add filter option with compoiression algorithm
#			z	gzip		<.tar.gz extension>
#			j	bzip2		<tar.bz2 extension>
#	
#	-->	Extracting (untar) an archive
#		-->	tar xvf archive_name.tar
#				x	extract
#				
#	-->	Listing an archive (View the tar archive file content without extracting)
#		-->	tar tvf file_name.tar
#				t	list (--list tuts auch)${NOC}"

line
echo -e "${RED}#How to Compile and Install Software from Source Code${NOC}"
echo -e "${NOC}#	-->	get tarball using wget <URL>
#	-->	Unpack with tar
#	-->	configuration 
#		-->	configure --help
#			./configure --> to actually configure
#		-->	creates build env, produces makefile
#		==>	make
#			Compilierung, necessary binaries are created
#		==>	make install
#			Installation${NOC}"

line
echo -e "${RED}#Into which directory should I install programs in Linux?${NOC}"
echo -e "${NOC}#		-->	/usr/local
#		-->	http://refspecs.linuxfoundation.org/FHS_2.3/fhs-2.3.html\n#
#	To get a list of the applications on your system that can use PAM (Pluggable Authentication Modules) in some way, type:
#		ldd /{,usr/}{bin,sbin}/* | grep -B 5 libpam | grep '^/'	
#	You can check a specific application for PAM functionality. If it returns anything, then it can use PAM.
#		ldd \$(which program_name) | grep libpam	${NOC}"
line

exit 