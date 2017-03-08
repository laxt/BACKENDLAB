-- 1. Hur många klasser går respektive kurs? Skriv ut kursens namn samt antal klasser.
select  count(elev.klass_kod) as AntalKlasser,
 klass.namn as Kursnamn from elev
inner join klass  on elev.klass_kod=klass.kod
group by elev.klass_kod;


-- 2. Beräkna den högsta lönen samt medellönen för lärare grupperat på avdelningsnamn för de 
-- avdelningar vars medellön > 10 000 kr
select avdelning.namn,
round(avg(larare.lon),0) as Madellon,
max(larare.lon) as Maxlon
from larare
inner join avdelning on avdelning.avdelningsnummer = larare.avdelning_avdelningsnummer
group by avdelning.avdelningsnummer
having Madellon > 10000;

-- 3. Vilka lärare och elever bor i Uppsala?
select  larare.fornamn , larare.efternamn from larare  where ort='UPPSALA'
union
select  elev.fornamn as elevfornamn, elev.efternamn as elevefternamn from elev where ort='UPPSALA';

-- 4. Lista samtliga lärare och vilka kurser de håller, även om de inte håller några kurser.

select fornamn, efternamn, 
undervisar.kurs_kod as kurskod,
kurs.namn as kursnamn
 from larare
left join undervisar on larare.anstallningsnummer = undervisar.larare_anstallningsnummer
left join kurs on undervisar.kurs_kod=kurs.kod;


