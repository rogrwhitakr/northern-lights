#! /usr/bin/env bash

source "${BASH_SOURCE[1]%/*}/helpers/initialisation.sh"
source "${BASH_SOURCE[1]%/*}/helpers/logging.sh"
USAGE=${BASH_SOURCE[1]%/*}/log-dependency-test.usage.sh
echo -e "${USAGE}"
source ${USAGE}
echo -e "${BASH_SOURCE[1]}"
# this is it!!
echo -e "${BASH_SOURCE[1]%/*}"

# Bash3 Boilerplate. from somewhere

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app

arg1="${1:-}"