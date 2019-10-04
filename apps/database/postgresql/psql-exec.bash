#! /usr/bin/env bash

# connect to database server on host X and create a backup of database Y in file Z

# list databases on host
psql --host=sql --user=postgres --list

# dump a database
pg_dump --host=sql --user=postgres redmine > redmine.sql --verbose

# setting evironment variable for automation
PGPASSWORD=xy