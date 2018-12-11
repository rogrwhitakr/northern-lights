CREATE SCHEMA names;

-- Create a role (user) with password
CREATE USER names PASSWORD 'names';

-- Grant privileges (like the ability to create tables) on new schema to new role
GRANT ALL ON SCHEMA names TO names;

-- Grant privileges (like the ability to insert) to tables in the new schema to the new role
GRANT ALL ON ALL TABLES IN SCHEMA names TO names;

DROP DATABASE names_database;
   
CREATE DATABASE names_database; 

-- DROP DOMAIN Geschlecht;
-- CREATE DOMAIN Geschlecht AS CHAR(1) DEFAULT 'm' CHECK( VALUE IN ('m', 'w'));


CREATE TABLE IF NOT EXISTS names (
    _ID             SERIAL UNIQUE PRIMARY KEY,
    name            Char(255) NOT NULL,
    first_name      Char(255) NOT NULL,
    last_name       Char(255) NOT NULL,
	reference_id    INT
    );
  
--ALTER TABLE klasse ADD COLUMN (schueler) CHAR(2) NULL; 	
  
CREATE TABLE IF NOT EXISTS schueler (
    Schueler_ID         SERIAL UNIQUE PRIMARY KEY,
    Vorname             VARCHAR(50) NOT NULL,
    Nachname            VARCHAR(50) NOT NULL,
    Geburtsdatum        DATE,
    Geschlecht          geschlecht,
	Klasse_ID           INT NOT NULL REFERENCES klasse(Klasse_ID ) 	ON UPDATE CASCADE ON DELETE CASCADE;
    );

-- ALTERATIONS NOT NECESSARY !!!	
ALTER TABLE schueler DROP CONSTRAINT IF EXISTS FK_klasse_id;

ALTER TABLE schueler ADD CONSTRAINT klasse_id_FKey
	FOREIGN KEY (Klasse_ID) REFERENCES klasse (Klasse_ID)	
	
CREATE TABLE IF NOT EXISTS person (
	person_ID			SERIAL UNIQUE PRIMARY KEY,
	Vorname             VARCHAR(50) NOT NULL,
    Nachname            VARCHAR(50) NOT NULL,
    Geburtsdatum        DATE,
    Geschlecht          geschlecht,
	Wohnort_ID			INT NOT NULL REFERENCES wohnort(Ort_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	Beruf_ID			INT NOT NULL REFERENCES beruf(Beruf_ID) ON DELETE CASCADE ON UPDATE CASCADE
	);
	
CREATE TABLE IF NOT EXISTS wohnort (
	Ort_ID				SERIAL UNIQUE PRIMARY KEY,
	Name				VARCHAR(50) NOT NULL,
	PLZ					INT NOT NULL,
	LAND				CHAR(2)
	);

CREATE TABLE IF NOT EXISTS beruf (
	Beruf_ID			SERIAL UNIQUE PRIMARY KEY,
	Bezeichnung			VARCHAR(50) NOT NULL
	);	
	
	
INSERT INTO klasse VALUES 
	(0,'ITSK 10d'),
	(1,'ITSK 11a'),
	(2,'ITSK 11b'),
	(3,'ITSK 11c'),
	(4,'ITSK 10a'),
	(5,'ITSK 10b'),
	(6,'ITSK 10c'),
	(7,'ITSK 12c'),
	(8,'ITSK 12a'),
	(9,'ITSK 12b'),	
	(10,'ITFI 10a'),	
	(11,'ITFI 12a'),	
	(12,'ITFI 11a'),	
	(13,'ITFI 10b'),	
	(14,'ITFI 11b'),	
	(15,'ITFI 11c'),	
	(16,'ITFI 12a'),	
	(17,'ITFI 12b'),	
	(18,'ITFI 12c')	
;	
	
INSERT INTO schueler (Vorname, Nachname, Geburtsdatum, Klasse_ID) VALUES 
	('Thomas','Stumpfegger','1984-12-12', 1),
	('Manuel', 'Neuer', '1985-01-01', 2),
	('Jonas','Hamlet','1986-06-02',18),
	('Perry','Cox','1969-01-01',14),
	('Jonathan','McMurdo','1944-11-15',16),
	('Stefan','Colbert','2001-10-05',4),
	('Alexander','Solschenizyn','1918-09-25',16)
;	
INSERT INTO schueler (Vorname,Nachname,Geburtsdatum,Geschlecht, Klasse_ID) VALUES 
	('Andreas','Perry','2001-11-05','m', 3),
	('Ilse','Heidegger','1988-05-05','w', 4),
	('Andrea','Kleinert','1986-04-02','w',5),
	('Emily', 'Talbert', '1995-05-06', 'w',6),
	('Tamara', 'Kos', '1996-02-06', 'w',6),
	('Robert','Stadlober', '1975-06-02', 'm', 1),
	('Anja', 'Cicero', '1944-01-05', 'w', 2),
	('Natascha', 'Hansen','2001-08-05','w',3),
	('Andromeda','Rogaschowa','2001-09-11','w',4),
	('Alexandra','Romero','1988-05-15','w',13),
	('Helena','Kind','1995-11-07','w',15)
;	
INSERT INTO schueler (Vorname,Nachname,Geburtsdatum,Geschlecht, Klasse_ID) VALUES
	('Johannes', 'Klopnik','2001-11-05','m', (SELECT klasse_id FROM klasse WHERE bezeichnung = 'ITSK 11a')),
	('Michaela', 'Rieger','2001-10-05','w', (SELECT klasse_id FROM klasse WHERE bezeichnung = 'ITSK 10a')),
	('Jasmin', 'Karl','1991-10-05','w', (SELECT klasse_id FROM klasse WHERE bezeichnung = 'ITSK 10a')),
	('Antonia', 'Klopnik','1944-01-15','w', (SELECT klasse_id FROM klasse WHERE bezeichnung = 'ITSK 11b')),
	('Rosie','Sobtsckack', '1987-04-02','w',(SELECT klasse_id FROM klasse WHERE bezeichnung = 'ITSK 12b')),
	('Felicity','Sobtsckack', '1987-04-02','w',(SELECT klasse_id FROM klasse WHERE bezeichnung = 'ITSK 12b'))
;	


DROP VIEW n_view,s_view,j_view, c_view;	

CREATE VIEW n_view AS 
	SELECT Vorname,Nachname FROM schueler;

CREATE VIEW j_view (vorname,nachname,Klasse) AS
	SELECT s.vorname,s.nachname,k.bezeichnung FROM schueler s
	JOIN klasse k using (klasse_id)
	ORDER BY k.bezeichnung ASC
	;	