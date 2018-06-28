#! /usr/bin/env bash

# ######################################################################################
# BASH SCRIPT TEMPLATE
#   HISTORY:
#
#   2018-06-13 - v1.0.0  -  First Creation (mostly by stealing from others)
#   2018-06-15 - v1.1.0  -  got some understanding as to what some parts do,
#                           the debugging set is pretty awesome. wrapping in a function
#                           may need to be rethought
#                           the exit trap is too rudimentary as of now, TODO
#   2018-06-27 - v2.0.0  -  moved some constant functions to helpers, sourcing those
#                           from now on
#
# ######################################################################################

# TODO: some sourcing of default variables 
# like colors and script vars
#    source "$(dirname "${BASH_SOURCE[0]}")/source.sh"
#    printf '%s%b' "$1" "$ta_none"
 #   echo "${script_path}"

# VARIABLES
#   VERSION
version="1.1.0"

#   FLAGS - can be overridden by user input?
quiet=0
verbose=0
force=0
strict=0
debug=0

#   ERROR CODES - not in use so far
# but they work
EXIT_SUCCESS=0
EXIT_FAILURE=1
EXIT_ERROR=2
EXIT_BUG=10

color_init
flags_init

while getopts ":u:p:fqlhsvd" opt; do
    case "${opt}" in
        u) # user
            u=${OPTARG}
            id -u "${u}" && \
                echo "success!" || \
                echo "failure!"
            ;;
        p) # password
            p=${OPTARG}
            if [[ -z "${OPTARG}" ]]; then
                echo -e "no value provided for password!"
                usage
            fi      
            echo "-p was triggered, Parameter: $OPTARG" >&2
            ;;
        
        # force -> this seems a bit difficult / or needs to be handled with care. 
        # anytime "read" or sudo command occurs, i will need to pass the thngy provided
        # read is probably easy, but needs to be incorporated into the script then
        # sudo, hm. i will need to look at that one....
        f) force flag # force  
            f=${OPTARG}
            ;;
        q)
            q=${OPTARG}
            ;;
        l)
            l=${OPTARG}
            ;;
        h)
            usage
            ;;

        # debugging options
        d) # debug
            debug=1
            flags_init ${debug}
            ;;
        v) # verbose
            verbose=1
            flags_init ${verbose}
            ;;
        s) # strict
            strict=1
            flags_init ${strict}
            ;;      
        \?)
            echo "Invalid option: $OPTARG" 1>&2
            ;;    
        :)
            # If no argument is provided getopts will set opt to :.
            # recognize this error condition by catching the : case 
            # and printing an appropriate error message.
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            ;;    

        *)
            echo -e "in *)...\nThis happens, if a flag i spassed that is defined, yet no case..in is available for it"
            ;;
    esac
done

shift $((OPTIND -1))



# DESC: the core function of the script
# NOTE: The creation of readonly variables in dependent functions (like color_init)
#       failed, moving these functions AFTER the main function seemed to solve this
#       THIS CANNOT STAND. WHY is this happening?
#       Okay, seems it was the flag stuff 
# ARGS: $@: Arguments provided to the script
# OUTS: Magic!

function main() {

    local test="declared testvar"
    
    script_init
    echo -e "${script_name}"
    echo -e "${YELLOW}within main${NOC}"
    trap script_finish EXIT INT TERM
}

# Make it rain
main "$@"
