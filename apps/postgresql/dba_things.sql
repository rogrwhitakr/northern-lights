
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

--cli
psql -l