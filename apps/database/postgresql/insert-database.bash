#! /usr/bin/env bash

usage() {
    echo "$0"
    echo "usage:"
    echo "$0 -d [optional: backup directory] -f <sql-file>"
    exit 1
}

# minimalist args provision
while getopts ":f:dn:th" opt; do
    case "${opt}" in
    f) # sql file
        if [[ -e "${OPTARG}" ]]; then
            f=${OPTARG}
        else
            echo "no sql file provided!" && usage
        fi
        ;;
    d) # psql backup dir
        if [[ -d "${OPTARG}" ]]; then
            d=${OPTARG:-"/var/lib/pgsql/backups/"}
        else
            d="/var/lib/pgsql/backups/"
        fi
        ;;
    h) # usage output
        usage
        ;;
    \?)
        echo "Invalid option: $OPTARG" 1>&2
        ;;
    :)
        echo "Invalid option: $OPTARG requires an argument" 1>&2
        ;;
    *)
        echo -e "in *)...\nThis happens, if a flag i spassed that is defined, yet no case..in is available for it"
        ;;
    esac
done

shift $((OPTIND - 1))

# if arg is empty we exit
if [[ -z "${f}" ]]; then
    usage
fi

# in future we could create some dated directories
# sudo -u root "mkdir"
# copy the file with correct permissions
sudo -u root install "${f}" --target-directory "${d}" --owner=postgres --group=postgres --mode=640 --verbose
