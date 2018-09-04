CREATE SCHEMA aurora;

-- Create a role (user) with password
CREATE USER aurora PASSWORD 'aurora';

-- Grant privileges (like the ability to create tables) on new schema to new role
GRANT ALL ON SCHEMA aurora TO aurora;

-- Grant privileges (like the ability to insert) to tables in the new schema to the new role
GRANT ALL ON ALL TABLES IN SCHEMA aurora TO aurora;

-- Create a table planet in schema aurora
CREATE TABLE planet.aurora ( aurora varchar(20));

-- Insert a single record into new table
insert into planet.aurora (col<col>) values ('It works!');