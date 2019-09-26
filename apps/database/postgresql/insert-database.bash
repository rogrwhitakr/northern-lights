#! /usr/bin/env bash

usage() {
    echo "${0##*/}"
    echo "usage:"
    echo "sudo ${0##*/} -d [optional: backup directory] -f <sql-file>"
    exit 1
}

no_root() {
    echo "must be executed as root!"
    usage
}

# root check
if [[ "$(id -u)" != 0 ]]; then
    echo "nothing right now"
#    no_root
fi

# setting this as a default backup place
d="/var/lib/pgsql/backups"

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
    d) # psql backup dir (override hardcoded target)
        if [[ -d "${OPTARG}" ]]; then
            d=${OPTARG}
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

echo "creating directory ${d}"
sudo -u root mkdir "${d}"
sudo -u root chown postgres:postgres "${d}"

echo "${f##*/}"

echo "moving file ${f##*/} into backup directory ${d}"

# copy the file with correct permissions
sudo -u root install "${f}" --target-directory "${d}" --owner=postgres --group=postgres --mode=640 --verbose

# switching to user postgres and inserting the database

echo "inserting sql file into instance"
sudo -u postgres cd ~; psql < "${d}"/"${f##*/}" -a || echo error
exit 0

# annoying, it does not work always. a oneliner seems better then
# udo -u root install psql-names-database.sql --target-directory /var/lib/pgsql/backups --owner=postgres --group=postgres --mode=640 --verbose
 