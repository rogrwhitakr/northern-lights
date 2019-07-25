#! /usr/bin/env bash

function usage {
        print RED "use like dis: $0 -p pbf-file.pbf -p another-pbf-file.pbf -p and-another.pbf -o new-name.pbf"
        print "new name may be omitted."
        print "exiting."
        print LINE
        exit 1
}

# set base vars
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# get the printer if it does not exist
if [ ! -f "${__dir}/printer.bash" ]; then
  wget https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/script/helpers/printer.bash "${__dir}"/printer.bash --quiet
fi

# source the printer
source "${__dir}"/printer.bash

# install osmctools if not exist
# ubuntu is a gay operating system, FYI
print LINE
if [ -z "$(which osmconvert)" ]; then
  print RED "installing OSM Tools"
  sudo apt-get install osmctools -y
  print LINE
fi

# trap the deletion of any o5m files in the current dir
trap "rm -f *.o5m" EXIT INT TERM

# empty arg check
if [[ -z "${1}" ]]; then
    print RED "No argument passed!"
    usage
fi

# download relevant pbfs? should i do that? nah.... out of scope, bc all I will ever do with this scripts is build a map that ISN`T default
while getopts ":p:o:h" opt; do
    case "${opt}" in
        p) # array my bitch up
                if [[ "$(file -b ${OPTARG})" == "OpenStreetMap Protocolbuffer Binary Format" ]]; then
                        pbfs+=("$OPTARG")
                else
                        print RED "File ${OPTARG} is not a valid pbf file!"
                        usage
                fi
                ;;
        h) # usage output
                usage
                ;;
        o) # new name
                if [[ "${OPTARG#*.}" == "pbf" ]]; then
                        o="${OPTARG}"
                fi
                ;;
        \?)
                print RED "Invalid option: $OPTARG" 1>&2
                ;;
        :)
                print RED "Invalid option: $OPTARG requires an argument" 1>&2
                ;;
        *)
                print RED "in *)... This happens, if a flag is passed that is defined, yet no case..in is available for it"
                ;;
        esac
done

shift $((OPTIND - 1))


# do the conversion, depending on how may pbfs i have
print YELLOW "starting conversion"

for pbf in "${pbfs[@]}"; do
    print GREEN "Converting ${pbf} into o5m format"
    osmconvert "${pbf}" --out-o5m -o="${pbf}.o5m" --verbose
#|| print RED "something went wrong. Exiting" && exit 1
    print RED "done"
done

print LINE
print RED "combining all o5m files into a new pbf"
osmconvert *.o5m -o=new.o5m --verbose
osmconvert new.o5m --out-pbf --verbose > "${o:-"new.pbf"}"
print GREEN "Completed new pbf ${o:-"new.pbf"}"
print LINE

exit 0
