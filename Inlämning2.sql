drop database b18simla;
create database b18simla;
use b18simla;

## STRONG ENTITIES ##
create table skidåkare(
	namn varchar(20),
    vikt tinyint(2) unsigned,
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
    temperatur tinyint(5),
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
    väderTyp varchar(20),
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

create table tävlingsSnö(
    snöTyp varchar(10),
    tävlingsNamn varchar(20),
    primary key (snöTyp, tävlingsNamn),
    foreign key (snöTyp) references snö(typ),
foreign key (tävlingsNamn) references tävling(namn)
)engine=innodb;

create table tävlingsVäder(
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

## 1.
insert into skidåkare(namn, vikt) values ('Therese Johaug', 46);

## 2.
insert into tävling(namn, datum) values ('Mördarbacken', 20160110);
insert into skidåkare(namn, vikt) values ('Charlotte Kalla', 58);
insert into delta(skidåkarNamn, tävlingsNamn) values ('Charlotte Kalla', 'Mördarbacken'); # Lägg in skidnummer?

## 3.
insert into tävling(namn, datum) values ('Oberstdorf', 20160105);
insert into snö(typ, luftfuktighet) values ('Slask', 100);
insert into väder(typ, temperatur) values ('Extremt kallt', -20);
insert into tävlingsSnö(snöTyp, tävlingsNamn) values ('Slask', 'Oberstdorf');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Extremt kallt', 080000, 'Oberstdorf');

## 4.
insert into skidåkare(namn, vikt) values ('Markus Hellner', 75);
insert into väder(typ, temperatur) values ('Regnigt', 0);
insert into struktur(namn, grovlek) values ('Grov Julgran', '2mm');
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Klisterskida', 'Fischer', 'Markus Hellner', 3, 'Grov Julgran', 'Slask', 'Regnigt');

## 5.
insert into skidåkare(namn, vikt) values ('Anna Haag', 63);
insert into struktur(namn, grovlek) values ('Nedskuren', '1mm');
insert into snö(typ, luftfuktighet) values ('Kramsnö', 60);
insert into väder(typ, temperatur) values ('Vindstilla', -5);
insert into struktur(namn, grovlek) values ('Bullig Träplanka', '7mm');
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Lågt', 'Fischer', 'Anna Haag', 3, 'Bullig Träplanka', 'Kramsnö', 'Vindstilla');
insert into rillverktyg(fabrikat, kommentar, strukturNamn) values ('Swix', 'Helt otroligt snabb i kallföre', 'Nedskuren');

## 6.
insert into skidåkare (namn, vikt) values ('Emma Wikén', 62);
insert into skidåkare (namn, vikt) values ('Stina Nilsson', 55);
insert into valla(namn, typ) values ('Swix KX35', 'Klister');
insert into snö(typ, luftfuktighet) values ('Frost', 0);
insert into snö(typ, luftfuktighet) values ('Pudersnö', 10);
insert into väder(typ, temperatur) values ('Blåsigt', -1);
insert into struktur(namn, grovlek) values ('Slät Påskhare', '5mm');
insert into struktur(namn, grovlek) values ('Bränd Stock', '10mm');
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Högt', 'Fischer', 'Emma Wikén', 7, 'Slät Påskhare', 'Frost', 'Blåsigt');
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Medel', 'Adidas', 'Stina Nilsson', 2, 'Bränd Stock', 'Pudersnö', 'Vindstilla');
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX35', 'Stina Nilsson', 2);
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX35', 'Emma Wikén', 7);

## 7.
insert into tävling(namn, datum) values ('Lenzerheide', 20130201);
insert into väder(typ, temperatur) values ('Strålande solsken', 2);
insert into väder(typ, temperatur) values ('Spöregn', 0);
insert into snö(typ, luftfuktighet) values ('Stenhårt', 5);
insert into snö(typ, luftfuktighet) values ('Mjuk', 70);
insert into tävlingsSnö(snöTyp, tävlingsNamn) values ('Stenhårt', 'Lenzerheide');
insert into tävlingsSnö(snöTyp, tävlingsNamn) values ('Mjuk', 'Lenzerheide');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Strålande solsken', 100000, 'Lenzerheide');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Spöregn', 120000, 'Lenzerheide');

## 8.
insert into väder(typ, temperatur) values ('Snöstorm', -5);
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Kardborre', 'Atomic', 'Charlotte Kalla', 13, 'Grov Julgran', 'Frost', 'Snöstorm');
insert into valla(namn, typ) values ('Swix HF8', 'Glid');
insert into valla(namn, typ) values ('Swix KX45', 'Fäst');
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix HF8', 'Charlotte Kalla', 13);
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX45', 'Charlotte Kalla', 13);
## Det går inte att se vilka skidor som användes en specifik tävling eftersom modellen saknar en relation mellan dessa.

## 9.
insert into skidåkare (namn, vikt) values ('Marit Björgren', 58);
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Lågt', 'Madshus', 'Marit Björgren', 16, 'Nedskuren', 'Slask', 'Blåsigt');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Marit Björgren', 'Lenzerheide');
insert into valla(namn, typ) values ('Skigo HF-Gul', 'Glid');
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Skigo HF-Gul', 'Marit Björgren', 16);
## En glidvalla har varken en passande snötyp eller relationer för att se vilken tävling den användes i.

## 10.
insert into valla(namn, typ) values ('Swix KX70', 'Klister');
insert into rillverktyg(fabrikat, kommentar, strukturNamn) values ('Skigo', 'Inte imponerad', 'Nedskuren');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Anna Haag', 'Mördarbacken'); 
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Högt', 'Fischer', 'Anna Haag', 6, 'Nedskuren', 'Mjuk', 'Snöstorm');
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX70', 'Anna Haag', 6);
## Ett rillverktyg har ingen relation till tävling

## GENERATED DATA ##
## Strong entities
insert into skidåkare (namn, vikt) values ('Åke Svensson', 80);
insert into skidåkare (namn, vikt) values ('Peter Sjöberg', 77);
insert into skidåkare (namn, vikt) values ('Lisa Andersson', 62);
insert into skidåkare (namn, vikt) values ('Madde Persson', 65);
insert into tävling(namn, datum) values ('Hammarbybacken', 20180101);
insert into tävling(namn, datum) values ('Åre', 20100310);
insert into tävling(namn, datum) values ('Säfsen', 20140207);
insert into valla(namn, typ) values ('Swix KX1337', 'Fäst');
insert into valla(namn, typ) values ('Swix KX55', 'Klister');

#Weak entities
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Kardborre', 'Atomic', 'Madde Persson', 1, 'Grov Julgran', 'Frost', 'Snöstorm');
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Klisterskida', 'OneWay', 'Lisa Andersson', 13, 'Bränd Stock', 'Frost', 'Strålande solsken');
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Klisterskida', 'OneWay', 'Markus Hellner', 2, 'Grov Julgran', 'Kramsnö', 'Spöregn');
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Klisterskida', 'Atomic', 'Peter Sjöberg', 14, 'Bullig Träplanka', 'Stenhårt', 'Extremt kallt');
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Lågt', 'Madshus', 'Åke Svensson', 9, 'Nedskuren', 'Kramsnö', 'Blåsigt');
insert into skidor(spann, fabrikat, åkarNamn, nummer, strukturNamn, snöTyp, väderTyp) values ('Lågt', 'Madshus', 'Stina Nilsson', 22, 'Nedskuren', 'Kramsnö', 'Blåsigt');
insert into rillverktyg(fabrikat, kommentar, strukturNamn) values ('Skigo', 'Fantastiskt effektiv i varmföre', 'Bränd Stock');
insert into rillverktyg(fabrikat, kommentar, strukturNamn) values ('Skiwent', 'Extraordinärt verksam i medelföre', 'Slät Påskhare');
insert into rillverktyg(fabrikat, kommentar, strukturNamn) values ('Swax', 'Oslagbar smidighet', 'Slät Påskhare');

#Relations
insert into delta(skidåkarNamn, tävlingsNamn) values ('Madde Persson', 'Mördarbacken');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Peter Sjöberg', 'Mördarbacken'); 
insert into delta(skidåkarNamn, tävlingsNamn) values ('Stina Nilsson', 'Mördarbacken'); 
insert into delta(skidåkarNamn, tävlingsNamn) values ('Charlotte Kalla', 'Hammarbybacken'); 
insert into delta(skidåkarNamn, tävlingsNamn) values ('Emma Wikén', 'Hammarbybacken');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Stina Nilsson', 'Oberstdorf');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Emma Wikén', 'Oberstdorf');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Stina Nilsson', 'Lenzerheide');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Markus Hellner', 'Lenzerheide');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Emma Wikén', 'Åre');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Peter Sjöberg', 'Säfsen');
insert into delta(skidåkarNamn, tävlingsNamn) values ('Markus Hellner', 'Säfsen');
insert into tävlingsSnö(snöTyp, tävlingsNamn) values ('Kramsnö', 'Hammarbybacken');
insert into tävlingsSnö(snöTyp, tävlingsNamn) values ('Frost', 'Åre');
insert into tävlingsSnö(snöTyp, tävlingsNamn) values ('Pudersnö', 'Säfsen');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Spöregn', 115000, 'Mördarbacken');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Spöregn', 130000, 'Hammarbybacken');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Blåsigt', 130000, 'Hammarbybacken');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Regnigt', 130000, 'Hammarbybacken');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Snöstorm', 130000, 'Hammarbybacken');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Strålande Solsken', 130000, 'Hammarbybacken');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Vindstilla', 130000, 'Hammarbybacken');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Extremt kallt', 130000, 'Hammarbybacken');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Snöstorm', 084500, 'Åre');
insert into tävlingsVäder(väderTyp, tid, tävlingsNamn) values ('Snöstorm', 102000, 'Säfsen');
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX55', 'Peter Sjöberg', 14);
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX1337', 'Madde Persson', 13);
insert into vallaSkidor(vallNamn, åkarNamn, skidNr) values ('Swix KX70', 'Stina Nilsson', 22);


## Frågeoperationer
# 1. 
SELECT skidåkare.vikt 
FROM skidåkare 
WHERE skidåkare.namn='Therese Johaug';

# 2.
SELECT tävling.namn, tävling.datum 
FROM tävling 
WHERE tävling.namn='Mördarbacken';

# 3.
SELECT skidåkare.vikt 
FROM skidåkare, tävling, delta 
WHERE skidåkare.namn=delta.skidåkarNamn 
AND tävling.namn=delta.tävlingsNamn 
AND tävling.datum='20160105';

# 4.
SELECT skidåkare.namn 
FROM skidåkare, skidor, struktur 
WHERE skidåkare.namn=skidor.åkarNamn 
AND struktur.namn=skidor.strukturNamn 
AND skidor.fabrikat='Madhus' 
AND skidor.nummer = 3;
# Ingen data hämtas då ingen av skidåkarnas skidor är tillverkade av Madhus

# 5.
SELECT väder.typ 
FROM väder, tävling, tävlingsVäder 
WHERE tävling.namn=tävlingsVäder.tävlingsNamn 
AND väder.typ=tävlingsVäder.väderTyp 
AND tävlingsVäder.tid='120000';
# Modellen stödjer inte relationer mellan tävling och skidor. I relationen "Delta" kan nyckeln "skidNummer" läggas till så varje deltagare måste använda ett par skidor

# 6.
SELECT s1.namn, s2.namn, s1.vikt 
FROM skidåkare as s1, skidåkare as s2 
WHERE  s1.namn!=s2.namn 
And s1.vikt=s2.vikt LIMIT 2;
# Hämta namnen och vikt från två likadana tabeller där namnen inte är lika och där vikten är lika. Begränsa till 2 då det finns 4 kombinationer

# 7.
SELECT skidåkare.namn 
FROM skidåkare 
WHERE NOT EXISTS(SELECT * FROM delta WHERE skidåkare.namn=delta.skidåkarNamn);
# Hämta alla namn från delta och joina namn från skidåkare och deltagare. Skriv ut de namnen som inte "kopplades"/hittades

# 8.
SELECT tävling.namn 
FROM tävling 
WHERE NOT EXISTS (SELECT * FROM väder 
WHERE NOT EXISTS (SELECT * FROM tävlingsVäder WHERE tävlingsVäder.väderTyp=väder.typ AND tävlingsVäder.tävlingsNamn=tävling.namn));
# Hämta alla tävlingar som har samtliga vädertyper. beskriv bättre


# 9.
SELECT DISTINCT snöTyp 
FROM tävlingsSnö;
# Hämta snötyper som varit funnits vid tävlingar (finns i tävlingsSnö) och begränsa till max 1 av samma snötyp med DISTINCT

# 10.
SELECT skidåkarNamn
FROM delta
GROUP BY skidåkarNamn
HAVING COUNT(*) = 2;
# Hämta alla skidåkares namn från delta som dyker upp exakt 2 gånger, gruppera vid namn för att ta bort dupletter

# 11.
SELECT *
FROM valla
ORDER BY namn DESC;
# Hämtar alla vallor och sorterar i DESCENDING (fallande) ordning

# 12.
SELECT AVG (vikt) 
FROM skidåkare;
# Hämtar AVERAGE (medelvärdet) vikt från skidåkare

# 13.
SELECT AVG (skidåkare.vikt), delta.tävlingsnamn
FROM delta, skidåkare
WHERE delta.skidåkarNamn=skidåkare.namn
GROUP BY delta.tävlingsNamn;
# Joina delta och skidåkare för att kunna ta fram medelvikten för tävlingen, gruppera vid tävlingsnamn, ta fram medelvikten

# 14.
SELECT DISTINCT fabrikat 
FROM rillverktyg
WHERE fabrikat LIKE "S%";
# DISTINCT + S följt av modulus listar alla unika fabrikat som börjar på bokstaven S

# 15.
SELECT DISTINCT fabrikat
FROM rillverktyg
WHERE (SELECT LENGTH (fabrikat) = 5);
# Ta fram unika fabrikat som är exakt 5 bokstäver långa

# 16.
SELECT MIN(temperatur)
FROM väder;
# Visa minimum temperatur för väder

# 17.
SELECT namn, datum
FROM tävling
ORDER BY datum DESC LIMIT 1;
# Sortera tävlingar efter datum i fallande ordning, begränsa tabellen till ett svar

# 18.
SELECT *
FROM tävling
ORDER BY DAY(datum) DESC;
# visa bara namnet

# 19.
UPDATE skidåkare
SET vikt = vikt * 1.1
WHERE vikt >= 50 AND vikt <= 60;
# Öka vikten för alla skidåkare med en vikt mellan 50 och 60 kg med 10% (vikt + (vikt *0.1)

# 20.
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM skidåkare
WHERE namn = 'Anna Haag';
SET FOREIGN_KEY_CHECKS=1;
# Ta bort skidåkaren Anna Haag

# 21.
SELECT * FROM skidor;
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM skidor
WHERE nummer = 2 AND åkarNamn = 'Markus Hellner';
SET FOREIGN_KEY_CHECKS=1;
SELECT * FROM skidor;
# Ta bort skidorna med numret 3 och ägaren Markus Hellner