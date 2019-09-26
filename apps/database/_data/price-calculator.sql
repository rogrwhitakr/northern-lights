
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

drop domain industry;

create domain industry as char(3) default 'OIL' check( VALUE in ('OIL',
'BEV',
'TRP',
'MLK',
'STN',
'LPG' ,
'WST'));

drop domain lang;

create domain lang as char(2) default 'DE' check( VALUE in ('DE',
'EN'));

create table if not exists prospect ( _prospect_id serial unique primary key,
company_name char(255) null,
company_industry industry null,
contact_person char(255) null );

create table if not exists price_list ( _price_list_id serial unique primary key,
item_name char(255) not null,
item_price int not null );

create table if not exists price_list_description ( _price_list_description_id serial unique primary key,
item_description char(1000) null,
item_description_id int not null references price_list(_price_list_id) on
update
	cascade on
	delete
		cascade,
		description_language lang not null );

create table if not exists item_list ( _item_list_id serial unique primary key,
item_id int not null references price_list(_price_list_id) on
update
	restrict,
	amount int not null );

create table if not exists prospect_offer ( _prospect_offer_id serial unique primary key,
offer_title char(255) null,
offer_language lang not null,
reference_id int,
primary_group_ID int not null references primary_group(_group_ID) on
update
	cascade on
	delete
		cascade );