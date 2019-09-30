drop table artist;
create table artist (
	_artist_id SERIAL UNIQUE PRIMARY KEY,
	DisplayName Char(1000) NULL,
	ArtistBio Char(1000) null,
	Nationality Char(1000) NULL,
	Gender Char(1000) null,
	BeginDate int NULL,
	EndDate int NULL,
	Wiki_QID Char(1000) NULL,
	ULAN Char(1000) NULL
)

select * from artist;

drop table artwork;
create table artwork (
Title Char(1000) NULL,
Artist Char(1000) NULL,
artist_id INT null,
ArtistBio Char(1000) NULL,
Nationality Char(1000) NULL,
BeginDate Char(1000) NULL,
EndDate Char(1000) NULL,
Gender Char(1000) NULL,
Date Char(1000) NULL,
Medium Char(11000) NULL,
Dimensions Char(1000) NULL,
CreditLine Char(11000) NULL,
AccessionNumber Char(11000) NULL,
Classification Char(11000) NULL,
Department Char(1000) NULL,
DateAcquired Char(1000) NULL,
Cataloged Char(11000) NULL,
ObjectID Char(11000) NULL,
URL Char(1000) NULL
)

select count(*) from artwork;

select distinct gender from artwork;

select * from artwork;

select aw.artist,art.artistbio from artwork aw
left outer join artist art on art."_artist_id" = aw.artist_id
where artist_id = null;


alter table artwork add column _artwork_id SERIAL UNIQUE PRIMARY key;

alter table artwork modify column artist_id references artist(_artist_id) on delete cascade on update cascade;

ALTER TABLE artwork ADD CONSTRAINT artist_id FOREIGN KEY (c1) REFERENCES artist (_artist_id);
