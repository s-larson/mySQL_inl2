drop database b18simla;
create database b18simla;
use b18simla;

## STRONG ENTITIES ##
create table skidåkare(
	namn varchar(20),
    vikt varchar(2),
    primary key (namn)
)engine=innodb;

create table tävling(
	namn varchar(20),
    datum date,
    primary key (namn)
)engine=innodb;

create table snö(
	typ varchar(10),
    luftfuktighet varchar(10),
    primary key (typ)
)engine=innodb;

create table väder(
	typ varchar(20),
    temperatur varchar(5),
    primary key (typ)
)engine=innodb;

create table struktur(
	namn varchar(20),
    grovlek varchar(5),
    primary key (namn)
)engine=innodb;

create table valla(
	namn varchar(20),
    typ varchar(10),
    primary key (namn)
)engine=innodb;

## WEAK ENTITIES ##
create table skidor(
    nummer int(2),
	strukturNamn varchar(20),
    åkarNamn varchar(20),
    fabrikat varchar(10),
    spann varchar(20),
    snöTyp varchar(10),
    väderTyp varchar(10),
    primary key (nummer,  åkarNamn),
    foreign key (strukturNamn) references struktur(namn),
    foreign key (snöTyp) references snö(typ),
	foreign key (väderTyp) references väder(typ),
    foreign key (åkarnamn) references skidåkare(namn)
)engine=innodb;

create table rillverktyg(
    fabrikat varchar(10),
	strukturNamn varchar(20),
    kommentar varchar(50),
    primary key (fabrikat, strukturNamn),
    foreign key (strukturNamn) references struktur(namn)
)engine=innodb;

## RELATIONS ##

create table delta(
    skidåkarNamn varchar(20),
    tävlingsNamn varchar(20),
    primary key (skidåkarNamn, tävlingsNamn),
    foreign key (skidåkarNamn) references skidåkare(namn),
    foreign key (tävlingsNamn) references tävling(namn)
)engine=innodb;

create table tävlingsdata1(
    snöTyp varchar(10),
    tävlingsNamn varchar(20),
    primary key (snöTyp, tävlingsNamn),
    foreign key (snöTyp) references snö(typ),
	foreign key (tävlingsNamn) references tävling(namn)
)engine=innodb;

create table tävlingsdata2(
    väderTyp varchar(20),
    tävlingsNamn varchar(20),
    tid time,
    primary key (väderTyp, tävlingsNamn),
    foreign key (tävlingsNamn) references tävling(namn),
    foreign key (väderTyp) references väder(typ)
)engine=innodb;

create table vallaSkidor(
	skidNr int(2),
    åkarNamn varchar(20),
    vallNamn varchar(20),
    primary key (åkarNamn, skidNr, vallNamn),
    foreign key (åkarNamn) references skidor(åkarNamn),
	foreign key (vallNamn) references valla(namn),
    foreign key (skidNr) references skidor(nummer)
)engine=innodb;

# STRONG
insert into skidåkare(namn, vikt) values ('Therese Johaug', 46);
insert into skidåkare(namn, vikt) values ('Charlotte Kalla', 58);
insert into skidåkare(namn, vikt) values ('Markus Hellner', 75);
insert into skidåkare(namn, vikt) values ('Anna Haag', 63);
insert into skidåkare (namn, vikt) values ('Emma Wikén', 62);
insert into skidåkare (namn, vikt) values ('Stina Nilsson', 55);
insert into snö(typ, luftfuktighet) values ('Slask', 100);
insert into snö(typ, luftfuktighet) values ('Mjuk', 90);
insert into snö(typ, luftfuktighet) values ('Stenhårt', 0);
insert into tävling(namn, datum) values ('Oberstdorf', 20160105);
insert into tävling(namn, datum) values ('Mördarbacken', 20160110);
insert into tävling(namn, datum) values ('Lenzerheide', 20130201);
insert into väder(typ, temperatur) values ('Extremt kallt', -20);
insert into väder(typ, temperatur) values ('Regnigt', 0);
insert into väder(typ, temperatur) values ('Strålande solsken', 2);
insert into väder(typ, temperatur) values ('Spöregn', 0);
insert into struktur(namn, grovlek) values ('Grov Julgran', '2mm');
insert into struktur(namn, grovlek) values ('Nedskuren', '1mm');
insert into valla(namn, typ) values ('Swix KX35', 'Klister');
insert into valla(namn, typ) values ('Swix HF8', 'Glid');
insert into valla(namn, typ) values ('Swix KX45', 'Fäst');
insert into valla(namn, typ) values ('Skigo HF-Gul', 'Glid');

#WEAK
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Klisterskida', 'Fischer', 'Markus Hellner', 3, 'Grov Julgran', 'Slask', 'Regnigt');
insert into skidor(spann, fabrikat, åkarNamn, nummer) values ('Lågt', 'Fischer', 'Anna Haag', 3);
insert into skidor(åkarNamn, nummer) values ('Emma Wikén', 7);
insert into skidor(åkarNamn, nummer) values ('Stina Nilsson', 2);
insert into skidor(åkarNamn, nummer) values ('Charlotte Kalla', 13);
insert into rillverktyg(fabrikat, kommentar, strukturNamn) values ('Swix', 'Helt otroligt snabb i kallföre', 'Nedskuren');
insert into rillverktyg(fabrikat, strukturNamn) values ('Skigo', 'Nedskuren'); # Lägg till tävling som kommentar? 

#RELATIONS
insert into delta(skidåkarNamn, tävlingsNamn) values ('Charlotte Kalla', 'Mördarbacken'); # Lägg in skidnummer?
insert into tävlingsdata1(snöTyp, tävlingsNamn) values ('Slask', 'Oberstdorf');
insert into tävlingsdata1(snöTyp, tävlingsNamn) values ('Stenhårt', 'Lenzerheide');
insert into tävlingsdata1(snöTyp, tävlingsNamn) values ('Mjuk', 'Lenzerheide');
insert into tävlingsdata2(väderTyp, tid, tävlingsNamn) values ('Extremt kallt', 080000, 'Oberstdorf');
insert into tävlingsdata2(väderTyp, tid, tävlingsNamn) values ('Strålande solsken', 095000, 'Lenzerheide');
insert into tävlingsdata2(väderTyp, tid, tävlingsNamn) values ('Spöregn', 115000, 'Lenzerheide');
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX35', 'Stina Nilsson', 2);
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX35', 'Emma Wikén', 7);
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix HF8', 'Charlotte Kalla', 13);
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX45', 'Charlotte Kalla', 13);

select * from skidor;
select * from vallaSkidor;
