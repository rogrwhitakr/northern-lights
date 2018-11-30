

-- all this data must correspond to the config.php file in the kanboard directory
CREATE SCHEMA kanboard;

-- Create a role (user) with password
CREATE USER kanboard PASSWORD 'kanboard';

-- Grant privileges (like the ability to create tables) on new schema to new role
GRANT ALL ON SCHEMA kanboard TO kanboard;

-- create the database
CREATE DATABASE kanboard;

-- Grant privileges (like the ability to insert) to tables in the new schema to the new role
-- GRANT ALL ON ALL TABLES IN SCHEMA aurora TO aurora;