DROP DATABASE if exists names;
-- create database 
CREATE DATABASE names; 

-- this ("use database") is some mysql specific instruction set. found on stackoverflow:
-- instead of use names;
-- create database -> metacommand \connect <database> -> create schema

\connect names;

-- within that database, we create the schema
drop schema if exists names;
create schema names;

-- we create the USER (not role) of names with the login privilege
drop user if exists names;
create user names password 'names';
-- as the group role grp_login exists now, we use that
grant grp_login to names;

-- Grant names user access to names database and schema
grant names to names;
GRANT names ON SCHEMA names TO names;

-- Grant privileges (like the ability to insert) to tables in the new schema to the new role
GRANT names ON ALL TABLES IN SCHEMA names TO names;

-- change the DBO
ALTER DATABASE names OWNER TO names;

-- we call it flavour, because why now
-- cascading the deletion

DROP TABLE flavour CASCADE;
DROP TABLE names;
DROP TABLE primary_group;

CREATE TABLE IF NOT EXISTS flavour (
	_show_id       			SERIAL UNIQUE PRIMARY KEY,
    name                    Char(255) NOT NULL
	);	

CREATE TABLE IF NOT EXISTS primary_group (
	_group_id   			SERIAL UNIQUE PRIMARY KEY,
    name                    Char(255) NOT NULL,
    show_ID                 INT NOT NULL REFERENCES flavour(_show_ID) ON UPDATE CASCADE ON DELETE CASCADE
 
	);	

CREATE TABLE IF NOT EXISTS names (
    _ID                     SERIAL UNIQUE PRIMARY KEY,
    first_name              Char(255) NULL,
    last_name               Char(255) NULL,
	reference_id              INT,
   	primary_group_ID        INT NOT NULL REFERENCES primary_group(_group_ID) ON UPDATE CASCADE ON DELETE CASCADE
    );


INSERT INTO flavour (name) VALUES
    ('Serenity'),
    ('Person of Interest')
    ;

INSERT INTO primary_group (name, show_ID) VALUES
    ('NorthernLights',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('Person of Interest',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('Organised Crime',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('The Brotherhood',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('NYPD',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('HR',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('FBI',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('The Government',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('CIA',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('Decima Technologies',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('Vigilance',(SELECT _show_ID FROM flavour WHERE name = 'Person of Interest')),
    ('Serenity',(SELECT _show_ID FROM flavour WHERE name = 'Serenity')),
    ('Alliance',(SELECT _show_ID FROM flavour WHERE name = 'Serenity'))
;

INSERT INTO names (first_name,last_name, primary_group_ID) VALUES
('John','Reese',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Harold','Finch',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Joss','Carter',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Lionel','Fusco',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Sameen','Shaw',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Root','',(SELECT _group_id FROM primary_group WHERE name = 'NorthernLights')),
('Jessica','Arndt',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Grace','Hendricks',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Nathan','Ingram',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Will','Ingram',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Taylor','Carter',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Lee','Fusco',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Zoe','Morgan',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Leon','Tao',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Harper','Rose',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Caleb','Phipps',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Logan','Pierce',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Carl','Elias',(SELECT _group_id FROM primary_group WHERE name = 'Person of Interest')),
('Anthony','Marconi',(SELECT _group_id FROM primary_group WHERE name = 'Organised Crime')),
('Bruce','Moran',(SELECT _group_id FROM primary_group WHERE name = 'Organised Crime')),
('Gianni','Moretti',(SELECT _group_id FROM primary_group WHERE name = 'Organised Crime')),
('Peter','Yogorov',(SELECT _group_id FROM primary_group WHERE name = 'Organised Crime')),
('Dominic','Besson',(SELECT _group_id FROM primary_group WHERE name = 'The Brotherhood')),
('Link','Cordell',(SELECT _group_id FROM primary_group WHERE name = 'The Brotherhood')),
('Cal','Beecher',(SELECT _group_id FROM primary_group WHERE name = 'NYPD')),
('Bill','Szymanski',(SELECT _group_id FROM primary_group WHERE name = 'NYPD')),
('Dani','Silva',(SELECT _group_id FROM primary_group WHERE name = 'NYPD')),
('Alonzo','Quinn',(SELECT _group_id FROM primary_group WHERE name = 'HR')),
('Patrick','Simmons',(SELECT _group_id FROM primary_group WHERE name = 'HR')),
('Artie','Lynch',(SELECT _group_id FROM primary_group WHERE name = 'HR')),
('Womack','',(SELECT _group_id FROM primary_group WHERE name = 'HR')),
('Raymond','Terney',(SELECT _group_id FROM primary_group WHERE name = 'HR')),
('Mike','Laskey',(SELECT _group_id FROM primary_group WHERE name = 'HR')),
('Nicholas','Donnelly',(SELECT _group_id FROM primary_group WHERE name = 'FBI')),
('Brian','Moss',(SELECT _group_id FROM primary_group WHERE name = 'FBI')),
('Alicia','Corwin',(SELECT _group_id FROM primary_group WHERE name = 'The Government')),
('Denton','Weeks',(SELECT _group_id FROM primary_group WHERE name = 'The Government')),
('Special','Counsel',(SELECT _group_id FROM primary_group WHERE name = 'The Government')),
('Hersh','',(SELECT _group_id FROM primary_group WHERE name = 'The Government')),
('Control','',(SELECT _group_id FROM primary_group WHERE name = 'The Government')),
('Devon','Grice',(SELECT _group_id FROM primary_group WHERE name = 'The Government')),
('Mark','Snow',(SELECT _group_id FROM primary_group WHERE name = 'CIA')),
('Tyrell','Evans',(SELECT _group_id FROM primary_group WHERE name = 'CIA')),
('Kara','Stanton',(SELECT _group_id FROM primary_group WHERE name = 'CIA')),
('John','Greer',(SELECT _group_id FROM primary_group WHERE name = 'Decima Technologies')),
('Jeremy','Lambert',(SELECT _group_id FROM primary_group WHERE name = 'Decima Technologies')),
('Martine','Rousseau',(SELECT _group_id FROM primary_group WHERE name = 'Decima Technologies')),
('Gabriel','Hayward',(SELECT _group_id FROM primary_group WHERE name = 'Decima Technologies')),
('Claire','Mahoney',(SELECT _group_id FROM primary_group WHERE name = 'Decima Technologies')),
('Jeff','Blackwell',(SELECT _group_id FROM primary_group WHERE name = 'Decima Technologies')),
('Peter','Collier',(SELECT _group_id FROM primary_group WHERE name = 'Vigilance'))

/*
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

I.A.V. Alexander
*/

select * from names;


