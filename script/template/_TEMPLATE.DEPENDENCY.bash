#! /usr/bin/env bash

# ######################################################################################
# BASH SCRIPT TEMPLATE
#   HISTORY:
#
#   2018-06-13 - v0.0.1  -  First Creation (mostly by stealing from others)
#   2018-06-15 - v0.1.0  -  got some understanding as to what some parts do,
#                           the debugging set is pretty awesome. wrapping in a function
#                           may need to be rethought
#                           the exit trap is too rudimentary as of now, TODO
#   2018-06-27 - v0.2.0  -  moved some constant functions to helpers, sourcing those
#                           from now on
#   2018-06-27 - v0.2.1  -  any traps must not be sourced, as error code transmission
#                           "fails", i.e. the (successful) return code of sourcing is 
#                           taken
#   2018-06-27 - v0.2.2  -  all getoptsy stuff is in the choice function now
#                           cleaned up calling order of functions, before main 
#
# ######################################################################################

# TODO: some sourcing of default variables 
# like colors and script vars
#    source "$(dirname "${BASH_SOURCE[0]}")/source.sh"
#    printf '%s%b' "$1" "$ta_none"
 #   echo "${script_path}"

# VARIABLES
#   VERSION
version="0.2.2"

#   ERROR CODES - work well, just need to be used
#   and need to fit the getopts thingy

EXIT_SUCCESS=0
EXIT_FAILURE=1
EXIT_ERROR=2
EXIT_BUG=10
ERROR_USER_UNKNOWN=20
ERROR_DIRECTORY_UNKNOWN=30

# DESC: sourcing of helper scripts
# ARGS: none
# OUTS: some variables, usage 
# INFO: copy and append sourcing of "usage"
#       edit "<yo-scripts-name>.usage.sh" to fit your script

source ./helpers/usage.sh
source ./helpers/initialisation.sh

# DESC: Trap exits with cleanup function
# ARGS: exit code -> trap <script_finish> EXIT INT TERM
# OUTS: None (so far)
# INFO: ERROR_CODE is put in local var, b/c otherwise one gets the return code
#       of the most recently completed command 
#       (and i dont care for knowing "echo" ran successfully...)
# INFO: sourcing this DOES NOT WORK!
#       any assigned return codes will be overwritten by the "sourcing" retrun code,
#       so this is useless!!! 

script_finish(){

  local ERROR_CODE="$?" 
  if [[ "${ERROR_CODE}" = 0 ]]; then
    echo -e "${GREEN}exit green, no errors${NOC}"
    echo -e "ERROR CODE: ${ERROR_CODE}"
  elif [[ "${ERROR_CODE}" = 20 ]]; then
    echo -e "${RED}user is unknown to the system!${NOC}"
  else  
    echo -e "${RED}exit RED${NOC}"
    echo -e "ERROR CODE: ${ERROR_CODE}"
  fi
  echo -e "${YELLOW}trap::script_finish::handler -> ${ERROR_CODE}${NOC}"
}


choice_init(){

while getopts ":u:p:fqlhsvd" opt; do
    case "${opt}" in
        u) # user
            u=${OPTARG}
            id -u "${u}" && \
                echo "success!" || \
                return "${ERROR_USER_UNKNOWN}"
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
        #p) -> pid would be something...       
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
}


# DESC: the core function of the script
# ARGS: $@: Arguments provided to the script
# OUTS: Magic!

function main() {

  # main seem sto assume some inits first...
    echo -e "${YELLOW}first we check choices${NOC}"
    choice_init "${@}"

    local test="declared testvar"
    
    echo -e "${script_name}"
    echo -e "${YELLOW}within main${NOC}"
}

# init the helpers
color_init
flags_init
script_init
trap script_finish EXIT INT TERM

# Make it rain
main "$@"
