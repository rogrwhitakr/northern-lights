insert into price_list (item_name, item_price) values(
	'Application-Server',1999
);

insert into price_list (item_name, item_price) values(
	('Application-Server',1999),
	('Application-DesktopClient',299),
	('Application-WebClient',299),
	('Application-Import',1299),
	('Application-Export',1299)
);

insert into price_list_description values(
	('Application-Server for Serving stuff', (select _price_list_id from price_list where item_name = 'Application-Server'), 'EN'),
	('Anwendungsserva für ausliefern, u know...', (select _price_list_id from price_list where item_name = 'Application-Server'), 'DE')
);