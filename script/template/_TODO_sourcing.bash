#! /usr/bin/env bash

# this assumes, the script is one level down
#source "${BASH_SOURCE[1]%/*}../helpers/init.bash"
#source "${BASH_SOURCE[1]%/*}../helpers/log.bash"
echo -e "${BASH_SOURCE[1]}"
echo -e "${BASH_SOURCE[0]}"
# this is it!!
echo -e "${BASH_SOURCE[1]%/*}"
echo -e "$(dirname "${BASH_SOURCE[0]}")"

#set -o errexit
#set -o pipefail
#set -o nounset
# set -o xtrace

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app

arg1="${1:-}"