#! /usr/bin/env bash
set -x

# [--------------------------------------------------------------]

# ATM, all I ever really do, is copy an absolute path,
# and source it:

# this contains most needed elements:
# -> print function
# -> debugging Options
# -> shopt / Getopts require manual building anyway
# -> script_finished function should be custom also, but maybe i can build a boilerplate?
# -> most important: do not build shit I DO NOT NEED / MAKES IT MORE COMNPLICATED THEN IT NEED BE

# [--------------------------------------------------------------]

#   VERSION
version="1.0.1"

source "/home/admin/MyScripts/script/helpers/init.bash"
source "/home/admin/MyScripts/script/helpers/log.bash"

strict=1
debug=0

script_init
flags_init

# [--------------------------------------------------------------]

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

# [--------------------------------------------------------------]
