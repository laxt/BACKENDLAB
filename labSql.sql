-- 1. Skriv ut en klasslista för samtliga klasser sorterat på efternamn.

select klass.namn as CourseName, elev.personnummer, elev.fornamn, elev.efternamn from elev
inner join klass
on klass.kod=elev.klass_kod
group by elev.efternamn;

-- 2.Skriv ut en lärarlista samt vilken avdelning varje lärare tillhör.
select * from larare
inner join avdelning 
on larare.avdelning_avdelningsnummer=avdelning.avdelningsnummer;

-- 3. Skapa ett schema över samtliga lektioner på en klass och i vilka salar de hålls i.
select kurs_kod as KURSKOD, namn as Lektioner, kurslokal.lokal_lokalkummer as Salar, kurslokal.datum as Dadum, kurslokal.tid as TID from kurs
inner join kurslokal
on kurs.kod= kurslokal.kurs_kod;

-- 3 2nd way answer

select dayname(kurslokal.datum) as DAG, kurslokal.datum as Datum, klass.kod as KURSKOD, lokal.namn as LOKALNAMN,
kurs.namn as KURSNAMN from klass
inner join kurs on klass.kod=kurs.klass_kod
inner join kurslokal on kurs.kod=kurslokal.kurs_kod
inner join lokal on kurslokal.lokal_lokalkummer=lokal.lokalkummer;

-- 4. Vilka elever på skolan har fått VG i en någon kurs?

SELECT distinct personnummer AS Personnummer, UPPER(fornamn) AS Förnamn, efternamn AS Efternamn, 
		 betyg AS Betyg FROM elev
	INNER JOIN kursbetyg ON elev.personnummer = kursbetyg.elev_personnummer
where kursbetyg.betyg='VG';
