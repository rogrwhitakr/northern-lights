
-- create a user
CREATE USER IF NOT EXISTS 'aurora'@'%' IDENTIFIED BY 'aurora';

-- create a database
CREATE DATABASE IF NOT EXISTS lights;
GRANT SELECT ON lights.* to 'aurora'@'%';

-- Creating a new user who can do anything (like root):
-- CREATE USER 'alexander'@'localhost';
-- GRANT ALL PRIVILEGES ON  *.* to 'alexander'@'localhost' WITH GRANT OPTION;
USE lights;

CREATE TABLE IF NOT EXISTS occupation (
	occupation_ID			SERIAL UNIQUE PRIMARY KEY,
	Description			VARCHAR(50) NOT NULL
	);	

INSERT INTO occupation (Description) VALUES 
	('Ninja'),
	('Desktop Warrior'),
	('Sun Starer'),
	('Angel Healer'),
	('Faith Healer'),
	('blubb');

CREATE TABLE IF NOT EXISTS person (
	person_ID			SERIAL UNIQUE PRIMARY KEY,
	firstname             VARCHAR(50) NOT NULL,
    lastname            VARCHAR(50) NOT NULL,
    birthday        DATE,
    occupation_ID			INT NOT NULL REFERENCES occupation(occupation_ID) ON DELETE CASCADE ON UPDATE CASCADE
	);

INSERT INTO person (firstname,lastname,birthday, occupation_ID) VALUES 
	('Andreas','Perry','2001-11-05', 3),
	('Ilse','Heidegger','1988-05-05', 4),
	('Andrea','Kleinert','1986-04-02',5),
	('Emily', 'Talbert', '1995-05-06', 6),
	('Tamara', 'Kos', '1996-02-06', 6),
	('Robert','Stadlober', '1975-06-02',  1),
	('Anja', 'Cicero', '1944-01-05',  2),
	('Natascha', 'Hansen','2001-08-05',3),
	('Andromeda','Rogaschowa','2001-09-11',4),
	('Alexandra','Romero','1988-05-15',13),
	('Helena','Kind','1995-11-07',15)
;	    