#! /usr/bin/env bash

cat <<EOF


./${script_name} [NAME]...[DEPENDENCY OPTION]...
 
DESCRIPTION:
    Helper for setting up a new script

ARGS: 
    name of the future script

OUTS: 
    copy of the script template in <repo>/script named to specification
    copy of usage depencency named to specification

VERSION: ${version}
	
OPTIONS:
 
    -n  future script name			        <REQUIRED>
    -e  elements to include			        <OPTIONAL>
    	init
    	choice
    	log
    	unitfile
    	usage

    -t  use dependency template			    <OPTIONAL>
    -h  Display help, version and exit		<OPTIONAL>

    Debugging options:
    -s  Exit script with null variables.  (set -o nounset)
    -v  verbose
    -d  run script in debug-mode (set -x)
	
PREREQUISITES / REQUIREMENTS:
    - name of future script
    - location is <repo>/script
	
EXAMPLES:
    - Create a script with dependencies 
        ./${script_name} -n testing-NICs.sh -d
    - Create a script with a single file
        ./${script_name} -n testing-NICs.sh

EOF