CREATE DATABASE benno; 

drop database benno;

CREATE ROLE benno LOGIN CREATEDB CREATEROLE INHERIT;

drop role benno;

drop user benno;

DROP USER benno;
CREATE USER benno PASSWORD 'benno';

-- Create a role with login an create db privileges
DROP ROLE names_role;
CREATE ROLE names_role LOGIN CREATEDB CREATEROLE INHERIT;

-- Grant privileges (like the ability to create tables) on new schema to new role
GRANT LOGIN ON SCHEMA postgres TO benno;

-- Grant privileges (like the ability to insert) to tables in the new schema to the new role
GRANT name ON ALL TABLES IN SCHEMA names TO names;