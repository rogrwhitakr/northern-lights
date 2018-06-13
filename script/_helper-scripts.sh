#! /usr/bin/env bash

#small check
find_in_target(){
if [[ ! -z $1 ]] || [[ ! -z $2 ]]; then
    echo -e "${YELLOW}args not found $1, $2${NOC}"
fi
echo -e "${YELLOW}source: $1 target: $2${NOC}"
}