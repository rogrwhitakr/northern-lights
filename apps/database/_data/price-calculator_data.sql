
-- template data
insert into price_list (item_name, item_price) values
	('Application-Server',1999),
	('Application-DesktopClient',299),
	('Application-WebClient',299),
	('Application-Import',1299),
	('Application-Export',1299)
;

-- template localisation data 
insert into price_list_description (item_description,item_description_id,description_language) values
	('Application-Server for Serving stuff', (select _price_list_id from price_list where item_name = 'Application-Server'), 'EN'),
	('Anwendungsserva für ausliefern, u know...', (select _price_list_id from price_list where item_name = 'Application-Server'), 'DE')
;

-- template prospect data 
insert into prospect (company_name, contact_person, company_industry) values 
	('Cahmaelion Industries, Inc.','Harper Rose','STN'),
	('NRO. src.','Caleb Phipps','MLK'),
	('Bingen S.A.','Logan Pierce','TRP'),
	('The Firm','Carl Elias','WST'),
	('Marconi pizza and olives','Anthony Marconi','OIL'),
	('Kantrell Inc.','Bruce Moran','OIL')
;

-- add some offers to different prospects
insert into prospect_offer(prospect, reference_id,offer_title,offer_language) values
    (1,'EMEA-0215','Angebot für Projekt 1','DE'),
    (1,'EMEA-5574','Folge-Angebot für Projekt 1','DE'),
    (3,'USCAN-653','Erweiterung','DE'),
    (5,'ASIA-000074','Some for EN, wit dat L-O-V-E','EN'),
    (4,'FR-002','Ninj dat bisch','EN')
;

insert into item_list(item_id,offer_id,amount) values
    -- offer 1
    (2,1,1),
    (4,1,4),
    (5,1,1),
    (6,1,1),
    -- offer 2
    (3,2,6),
    -- offer 2
    (2,4,1),
    (4,4,4),
    (5,4,1),
    (6,4,1)
;    

