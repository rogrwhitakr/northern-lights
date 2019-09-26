drop schema price_calculator;

create schema price_calculator;
-- Create a role with login an create db privileges

create role calculator LOGIN CREATEDB CREATEROLE inherit password 'calculator';
-- create user
drop role calculator;

grant all on database price_calculator to calculator;
grant all on schema public to calculator;

-- this i do not seem to need...
-- i can simply create the role. what is the difference betweeen user and role? 
create user calculator password 'calculator';
-- Grant privileges (like the ability to create tables) on new schema to new role
grant all on schema price_calculator to calculator;

create database price_calculator;

alter database price_calculator owner to calculator;