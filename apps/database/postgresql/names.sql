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

CREATE TABLE IF NOT EXISTS primary_group (
	_group_id   			SERIAL UNIQUE PRIMARY KEY,
    name                    Char(255) NOT NULL
	);	

CREATE TABLE IF NOT EXISTS names (
    _ID                     SERIAL UNIQUE PRIMARY KEY,
    name                    Char(255) NOT NULL,
    first_name              Char(255) NOT NULL,
    last_name               Char(255) NOT NULL,
	reference_id            INT
   	primary_group_ID        INT NOT NULL REFERENCES primary_group(_group_ID) ON UPDATE CASCADE ON DELETE CASCADE;

    );

--ALTER TABLE klasse ADD COLUMN (schueler) CHAR(2) NULL; 	
--ALTER TABLE schueler DROP CONSTRAINT IF EXISTS FK_klasse_id;
--ALTER TABLE schueler ADD CONSTRAINT klasse_id_FKey
--	FOREIGN KEY (Klasse_ID) REFERENCES klasse (Klasse_ID)	
	
INSERT INTO primary_group (name) VALUES
    ('NorthernLights'),
    ('Persons of Interest'),
    ('Organised Crime'),
    ('The Brotherhood'),
    ('NYPD'),
    ('HR'),
    ('FBI'),
    ('The Government'),
    ('CIA'),
    ('Decima Technologies'),
    ('Vigilance')
;

INSERT INTO names (first_name,last_name, primary_group_ID) VALUES

('John','Reese',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Harold','Finch',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Joss','Carter',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Lionel','Fusco',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Sameen','Shaw',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Root','',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),

POI
2.1.1	Jessica Arndt
2.1.2	Grace Hendricks
2.1.3	Nathan Ingram
2.1.4	Will Ingram
2.1.5	Taylor Carter
2.1.6	Lee Fusco
('Persons of Interest
2.2.1	Zoe Morgan
2.2.2	Leon Tao
2.2.3	Harper Rose
2.2.4	Caleb Phipps
2.2.5	Logan Pierce
2.3	Organised Crime figures
2.3.1	Carl Elias
2.3.2	Anthony Marconi
2.3.3	Bruce Moran
2.3.4	Gianni Moretti
2.3.5	Peter Yogorov
2.4	The Brotherhood
2.4.1	Dominic Besson
2.4.2	Link Cordell
2.4.3	Floyd
2.5	New York City Police Department
2.5.1	Cal Beecher
2.5.2	Bill Szymanski
2.5.3	Kane
2.5.4	Dani Silva
2.6	HR
2.6.1	Alonzo Quinn
2.6.2	Patrick Simmons
2.6.3	Artie Lynch
2.6.4	Womack
2.6.5	Raymond Terney
2.6.6	Mike Laskey
2.7	Federal Bureau of Investigation
2.7.1	Nicholas Donnelly
2.7.2	Brian Moss
2.8	The Government
2.8.1	Alicia Corwin
2.8.2	Denton Weeks
2.8.3	Special Counsel
2.8.4	Hersh
2.8.5	Control
2.8.6	Devon Grice
2.8.7	Brooks
2.9	The CIA
2.9.1	Mark Snow
2.9.2	Tyrell Evans
2.9.3	Kara Stanton
2.10 Decima Technologies
2.10.1	John Greer
2.10.2	Jeremy Lambert
2.10.3	Martine Rousseau
2.10.4	Gabriel Hayward
2.10.5	Claire Mahoney
2.10.6	Zachary
2.10.7	Jeff Blackwell
2.11	Vigilance
2.11.1	Peter Collier
'

'
1	Major characters
1.1	Malcolm Reynolds
1.2	Zoe Washburne
1.3	Hoban Washburne
1.4	Inara Serra
1.5	Jayne Cobb
1.6	Kaylee Frye
1.7	Simon Tam
1.8	River Tam
1.9	Derrial Book
2	Minor characters
2.1	Badger
2.2	Bester
2.3	Sheriff Bourne
2.4	Rance Burgess
2.5	Bridget
2.6	Dr. Caron
2.7	Lawrence Dobson
2.8	Jubal Early
2.9	Fanty and Mingo
2.10	Blue Gloves
2.11	Sir Warwick Harrow
2.12	Stitch Hessian
2.13	Fess Higgins
2.14	Magistrate Higgins
2.15	"The Interviewer"
2.16	Lenore
2.17	Dr. Mathias
2.18	Mr. Universe
2.19	Monty
2.20	Nandi
2.21	Adelei Niska
2.22	The Operative
2.23	Ott
2.24	Patience
2.25	Saffron
2.26	Tracey Smith
2.27	Gabriel and Regan Tam
2.28	Atherton Wing
'
DROP VIEW n_view,s_view,j_view, c_view;	

CREATE VIEW n_view AS 
	SELECT Vorname,Nachname FROM schueler;

CREATE VIEW j_view (vorname,nachname,Klasse) AS
	SELECT s.vorname,s.nachname,k.bezeichnung FROM schueler s
	JOIN klasse k using (klasse_id)
	ORDER BY k.bezeichnung ASC
	;	