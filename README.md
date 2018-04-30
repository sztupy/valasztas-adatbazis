Live SQL interfész
==================

http://valasztas.sztupy.hu/

A fenti link kis terhelésű szerveren fut, így esélyes, hogy lassú, vagy nem működik,
így ha lehet inkább töltsd le az adatokat innen: https://github.com/sztupy/valasztas-adatbazis/tree/master/sql
valamint a sémát innen: https://github.com/sztupy/valasztas-adatbazis/blob/master/schema.sql
és egy helyi adatbázisban használd

Az SQLite adatbázis elkészítve letölthető innen is: https://github.com/sztupy/valasztas-adatbazis/raw/master/deploy_tools/valasztas.sqlite3

Letöltés után, ha van docker-ed az alábbi paranccsal tudod a web interfészt előhozni:

    docker run -it --rm -p 8080:8080 -v /path/to/valasztas.sqlite3:/data/valasztas.sqlite3:ro -e SQLITE_DATABASE=valasztas.sqlite3 coleifer/sqlite-web

Lásd még
========

- NVI Dokumentáció: https://github.com/sztupy/valasztas-adatbazis/blob/master/NVI_tajekoztato.doc
- Eredmények reprezentálása gráffal: https://github.com/pcgejza/diplomamunka_valasztasi_adatok_graf

2018-as választási eredmények SQL-ben
=====================================

Pár példa keresés:

1. Adott szavazókör listát szavazatai

```sql
SELECT tlista.tnev, szavt.szav FROM szavf
  JOIN szavt ON szavf.jfid = szavt.jfid
  JOIN tlista ON szavt.jlid = tlista.tlid
  WHERE szavf.maz = '03' AND szavf.taz = '004' AND szavf.sorsz = '009'
  AND szavf.valtip = 'L'
```

2. Adott szavazókör egyéni szavazatai

```sql
SELECT ejelolt.nev, ejelolt.unev1, jlcs.nevt, szavt.szav FROM szavf
  JOIN szavt ON szavf.jfid = szavt.jfid
  JOIN ejelolt ON szavt.jlid = ejelolt.eid
  LEFT JOIN jlcs ON jlcs.jlcs = ejelolt.jlcs
  WHERE szavf.maz = '03' AND szavf.taz = '004' AND szavf.sorsz = '009'
  AND szavf.valtip = 'J'
```

3. Adott szavazókörben a listára és egyénire adott szavazatok különbsége

```sql
SELECT lista.maz, lista.taz, lista.sorsz, lista.tnev, lista.szav as listaszav, egyen.szav as egyenszav FROM
  (SELECT szavf.maz, szavf.taz, szavf.sorsz, tlista.tnev, szavt.szav FROM szavf
   JOIN szavt ON szavf.jfid = szavt.jfid
   JOIN tlista ON szavt.jlid = tlista.tlid
   WHERE szavf.maz = '03' AND szavf.taz = '004' AND szavf.sorsz = '009'
   AND szavf.valtip = 'L') as lista
 JOIN
  (SELECT szavf.maz, szavf.taz, szavf.sorsz, ejelolt.nev, ejelolt.unev1, jlcs.nevt, szavt.szav FROM szavf
   JOIN szavt ON szavf.jfid = szavt.jfid
   JOIN ejelolt ON szavt.jlid = ejelolt.eid
   LEFT JOIN jlcs ON jlcs.jlcs = ejelolt.jlcs
   WHERE szavf.maz = '03' AND szavf.taz = '004' AND szavf.sorsz = '009'
   AND szavf.valtip = 'J') as egyen
 ON lista.tnev = egyen.nevt AND lista.maz = egyen.maz and lista.taz = egyen.taz and lista.sorsz = egyen.sorsz
```

4. Szavazókörök, ahol a listán lényegesen kevesebb szavazat érkezett egy pártra, mint egyéniben

```sql
SELECT lista.maz, lista.taz, lista.sorsz, lista.tnev, lista.szav as listaszav, egyen.szav as egyenszav FROM
  (SELECT szavf.maz, szavf.taz, szavf.sorsz, tlista.tnev, szavt.szav FROM szavf
   JOIN szavt ON szavf.jfid = szavt.jfid
   JOIN tlista ON szavt.jlid = tlista.tlid
   AND szavf.valtip = 'L') as lista
 JOIN
  (SELECT szavf.maz, szavf.taz, szavf.sorsz, ejelolt.nev, ejelolt.unev1, jlcs.nevt, szavt.szav FROM szavf
   JOIN szavt ON szavf.jfid = szavt.jfid
   JOIN ejelolt ON szavt.jlid = ejelolt.eid
   LEFT JOIN jlcs ON jlcs.jlcs = ejelolt.jlcs
   AND szavf.valtip = 'J') as egyen
 ON lista.tnev = egyen.nevt AND lista.maz = egyen.maz and lista.taz = egyen.taz and lista.sorsz = egyen.sorsz
 WHERE listaszav*10 < egyenszav AND egyenszav>20
```

5. Előző ellenkezője: több a listát szavazat, pedig egyéniben is indult a párt

```sql
SELECT lista.maz, lista.taz, lista.sorsz, lista.tnev, lista.szav as listaszav, egyen.szav as egyenszav FROM
  (SELECT szavf.maz, szavf.taz, szavf.sorsz, tlista.tnev, szavt.szav FROM szavf
   JOIN szavt ON szavf.jfid = szavt.jfid
   JOIN tlista ON szavt.jlid = tlista.tlid
   AND szavf.valtip = 'L') as lista
 JOIN
  (SELECT szavf.maz, szavf.taz, szavf.sorsz, ejelolt.nev, ejelolt.unev1, jlcs.nevt, szavt.szav FROM szavf
   JOIN szavt ON szavf.jfid = szavt.jfid
   JOIN ejelolt ON szavt.jlid = ejelolt.eid
   LEFT JOIN jlcs ON jlcs.jlcs = ejelolt.jlcs
   AND szavf.valtip = 'J') as egyen
 ON lista.tnev = egyen.nevt AND lista.maz = egyen.maz and lista.taz = egyen.taz and lista.sorsz = egyen.sorsz
 WHERE listaszav > egyenszav*5 AND egyenszav > 0
 ```

6. Szavazókörök, ahol jelentős mennyiségű érvénytelen szavazat érkezett

```sql
SELECT maz,taz,sorsz,valtip,m
FROM "szavf" WHERE m > 20
```

7. Szavazókörök 85%-os részvétel felett

```sql
SELECT *
FROM "szavf" WHERE cast(f as float)/cast(a as float)>0.85
```

8. Szavazókörök, ahol volt FIDESZ delegált, de nem volt ellenzéki

```sql
SELECT distinct maz,taz,sorsz,telepls
FROM partdelegalt p WHERE
  exists
    (select 1 from partdelegalt pt where
      p.maz = pt.maz and
      p.taz = pt.taz and
      p.sorsz = pt.sorsz and
      pt.jellcsopid == 641)
  and not exists
    (select 1 from partdelegalt pt2 where
      p.maz = pt2.maz and
      p.taz = pt2.taz and
      p.sorsz = pt2.sorsz and
      pt2.jellcsopid != 641)
```

9. A csak FIDESZ által felügyelt szavazókörökben leadott érvényes és összes szavazatok aránya

```sql
SELECT sum(m),sum(f),cast(sum(m) as float) / cast(sum(f) as float)
FROM (
  SELECT distinct p.maz,p.taz,p.sorsz,p.telepls,valtip,szavf.m,szavf.f
  FROM partdelegalt p
  JOIN szavf on szavf.maz = p.maz and szavf.taz = p.taz and szavf.sorsz = p.sorsz
  WHERE not exists
    (select 1 from partdelegalt pt
       where p.maz = pt.maz and
             p.taz = pt.taz and
             p.sorsz = pt.sorsz and
             pt.jellcsopid != 641)
   and exists
    (select 1 from partdelegalt pt2
       where p.maz = pt2.maz and
             p.taz = pt2.taz and
             p.sorsz = pt2.sorsz and
             pt2.jellcsopid = 641)
  )
```

10. Pártdelegáltak listája körzetekben, ahol jelentős mennyiségű érvénytelen szavazat érkezett

```sql
SELECT p.maz,p.taz,p.sorsz,p.telepls,valtip,szavf.m,group_concat(megbz)
  FROM partdelegalt p
  JOIN szavf on szavf.maz = p.maz and szavf.taz = p.taz and szavf.sorsz = p.sorsz
  WHERE szavf.m > 40
  GROUP BY p.maz, p.taz, p.sorsz, p.telepls, valtip, szavf.m
```
