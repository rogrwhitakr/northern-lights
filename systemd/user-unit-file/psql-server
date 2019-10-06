#! /usr/bin/env bash

export PGUSER=postgres
export PGPASSWORD=postgres
export PGPORT=5432
export PGHOST=sql.northern-lights.one

if [[ -n "$1" ]]; then
    export PGDATABASE=$1
else
    echo "no database name provided, exiting backup-script $0"
    exit 1 
fi

pg_dump --host="${PGHOST}" --user="${PGUSER}" --port="${PGPORT}" $1 > $1.backup
exit 0