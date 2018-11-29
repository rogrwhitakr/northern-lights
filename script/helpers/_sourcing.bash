#! /usr/bin/env bash
set -x

# Set magic variables for current file & dir

# this is crude, but works: two down, and then...

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__dir="$(cd "$(dirname "${__dir}")" && pwd)"
source "${__dir}/script/helpers/init.bash"

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file})"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app

arg1="${1:-}"

exit 0