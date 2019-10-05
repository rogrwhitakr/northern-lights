#! /usr/bin/env bash

# connect to database server on host X and create a backup of database Y in file Z

# list databases on host
psql --host=sql --user=postgres --list

# dump a database
pg_dump --host=sql --user=postgres redmine > redmine.sql --verbose

# setting evironment variable for automation
PGPASSWORD=xy

# https://www.postgresql.org/docs/12/libpq-envars.html

PGHOST behaves the same as the host connection parameter.
PGHOSTADDR behaves the same as the hostaddr connection parameter. This can be set instead of or in addition to PGHOST to avoid DNS lookup overhead.
PGPORT behaves the same as the port connection parameter.
PGDATABASE behaves the same as the dbname connection parameter.
PGUSER behaves the same as the user connection parameter.
PGPASSWORD behaves the same as the password connection parameter