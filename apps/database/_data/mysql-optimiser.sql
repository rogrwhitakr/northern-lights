-- create a user
CREATE USER IF NOT EXISTS 'optimiser'@'%' IDENTIFIED BY 'optimiser';

-- create a database
CREATE DATABASE IF NOT EXISTS optimiser;
GRANT SELECT ON optimiser.* to 'optimiser'@'%';

USE optimiser;

-- create tables
CREATE TABLE IF NOT EXISTS run (
	ID			            SERIAL UNIQUE PRIMARY KEY,
	run_name    			VARCHAR(50) NOT NULL,
    non_failed_moves        INT NULL,
    accepted_moves          INT NULL,
    total_moves             INT NULL
	);	
