#! /usr/bin/env bash

#small check
find_in_target(){
if [[ ! -z $1 ]] || [[ ! -z $2 ]]; then
    echo -e "${YELLOW}args not found $1, $2${NOC}"
fi
echo -e "${YELLOW}source: $1 target: $2${NOC}"
}

# over @ the defensive script guid they recommend doing:
# abstact away the -d ==> function directory_exists
# looks like this then:

is_directory(){
    local directory="$1"
    [[ -d "${directory}" ]]
}

is_executable(){
    local executable="$1"
    [[ -x "${executable}" ]]
}

is_directory /var/log && echo "YES" || echo "NO"
is_directory /var/lag && echo "YES" || echo "NO"
is_executable /usr/bin/borg && echo "YES" || echo "NO"
is_executable /usr/bin/borg
if [[ "${?}" = 0 ]]; then
    echo "okilidokili"
fi    
is_executable /usr/bin/barg && echo "YES" || echo "NO"

if [[ "$(is_executable "/usr/bin/borg")" = 0 ]];then
    echo "we do shit"
    echo "i forgot to escape the \" today...."
else
    echo "maybe not..."    
fi

# okay that does not work like i want it to
# too much stripping of things away by the interpreter
# what good is a helper function i have to constantly double-check?