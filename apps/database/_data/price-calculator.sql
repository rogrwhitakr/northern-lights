-- hold data about a potential customer
 drop table if exists prospect;
-- hold data about prices and items
 drop table if exists price_list;
-- hold localised description data
 drop table if exists price_list_description;
-- hold data about a prospects offer itemised list
 drop table if exists item_list;
-- hold data about the offer to the prospect 
 drop table if exists prospect_offer;
-- unsure so far
 drop table if exists price_calculator;

drop domain if exists industry;

create domain industry as char(3) default 'OIL' check( VALUE in ('OIL',
'BEV',
'TRP',
'MLK',
'STN',
'LPG' ,
'WST'));

drop domain if exists lang;

create domain lang as char(2) default 'DE' check( VALUE in ('DE',
'EN'));

create table if not exists prospect ( _prospect_id serial unique primary key,
company_name char(255) null,
company_industry industry null,
contact_person char(255) null );

create table if not exists price_list ( _price_list_id serial unique primary key,
item_name char(255) not null,
item_price int not null );

create table if not exists price_list_description ( 
	_price_list_description_id 	serial unique primary key,
	item_description 			char(1000) null,
	item_description_id 		int not null references price_list(_price_list_id) on update cascade on delete cascade,
	description_language 		lang not null
);

create table if not exists item_list ( 
	_item_list_id 	serial unique primary key,
	item_id 		int not null references price_list(_price_list_id) on update restrict,
	offer_id 		int not null references prospect_offer(_prospect_offer_id) on update cascade on delete cascade,
	amount 			int not null
);

create table if not exists prospect_offer ( 
	_prospect_offer_id 	serial unique primary key,
	prospect	 		int not null references prospect(_prospect_id) on update cascade on delete cascade,
	reference_id 		char(255) not null, -- external ID of the offer
	offer_title 		char(255) null,
	offer_language 		lang not null,
);

-- in-place 
-- alter table prospect_offer add column prospect int not null references prospect(_prospect_id) on update cascade on delete cascade;
-- alter table prospect_offer modify column reference_id type char(255) not null;

select * from price_list
select * from prospect_offer
