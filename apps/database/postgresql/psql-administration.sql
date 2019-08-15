
-- creating databases owned by user
CREATE DATABASE dbname OWNER rolename;

-- create from cli
createdb -O rolename dbname

-- destroy
DROP DATABASE name;

-- from cli
dropdb dbname


--Full hierarchy is: server, database, schema, table 
-- query the server? database
SELECT datname FROM pg_database;
-- EQUIVALENt TO -> called a METACOMMAND
\l

-- get only portions of data, like the names of the databases:
psql -c 'SELECT datname FROM pg_database;'
psql --command='SELECT datname FROM pg_database;'

--cli
psql -l

-- backing up database
-- cli
-- can perform this backup procedure from any remote host that has access to the database
pg_dump <database> > <backup>
pg_dump -h <host> -p <port>

--Restoring the Dump
psql dbname < infile

--database name will not be created by this command, so
--it must created from template0 before executing psql
createdb -T template0 dbname
--Non-text file dumps are restored using the pg_restore utility.

-- stop on error:
psql --set ON_ERROR_STOP=on dbname < infile
-- specify single transaction
psql --single-transaction 
-- is pipable:
pg_dump -h host1 dbname | psql -h host2 dbname
-- Important: The dumps produced by pg_dump are relative to template0. 
-- This means that any languages, procedures, etc. added via template1 will also be dumped by pg_dump. 
-- As a result, when restoring, if you are using a customized template1, you must create the empty database from template0.

-- i created a directory scripts in 
-- /var/lib/pgsql
-- this is postgres "home"
-- chown this as postgres.postgres