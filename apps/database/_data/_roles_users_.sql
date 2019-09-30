--remove it all before
drop user IF EXISTS nathan;
drop role IF EXISTS grp_login;
drop role IF EXISTS grp_build;

-- get the available predefined roles
select * from pg_roles;
 
-- create a USER with a password, that can do nothing
CREATE user nathan WITH PASSWORD 'nathan';

-- we create an umbrella group for access
-- could also be group security = admins and else...
create role grp_login LOGIN;
create role grp_build CREATEDB CREATEROLE;

-- assign nathan to that role
grant grp_login to nathan;

-- assign a role and then take it away again
grant grp_build to nathan;
REVOKE grp_build from nathan;

drop role if exists grp_build;

-- create a database for nathan to play with
drop database if exists application;
create database application;

-- create the mapping
alter database application owner to nathan;
 
-- ok, now i conect as nathan and do something else.

