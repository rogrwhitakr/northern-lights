#! /usr/bin/env bash

# extract from borg archive

echo "extract from borg archive:
setting \$BORG_REPO to current archive:"

read -rp $'path: ' -ei $'/mnt/backup/borg' BORG_REPO;
echo "using BORG_REPO = $BORG_REPO"

_programme_check(){
    if [[ ! -z $1 ]] && [[ -x $1 ]]; then
        # check for path
        return $(which $1)
        echo $(which $1)
    else
        echo "something in if didnt go well"
    fi
}

_programme_check borg
_dir_check(){
if [[ -n "$1" ]] && [[ -d "$1" ]]; then
  return 0
else
  return 1
fi
}


# execution

borg list $BORG_REPO \
        --prefix '{hostname}-'

# Extract entire archive
# borg extract $BORG_REPO::my-files

# Extract entire archive and list files while processing
# borg extract --list $BORG_REPO::

# Verify whether an archive could be successfully extracted, but do not write files to disk
# borg extract --dry-run $BORG_REPO::my-files

# Extract the "src" directory
# borg extract $BORG_REPO::my-files home/USERNAME/src

# Extract the "src" directory but exclude object files
# borg extract $BORG_REPO::my-files home/USERNAME/src --exclude '*.o'