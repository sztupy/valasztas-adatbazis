-- Mandátumszerző jelöltek
CREATE TABLE szkepv (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Mandátum típusa
  -- (1: Egyéni választókerületi mandátum, 2: Országos listás mandátum, 3: Nemzetiségi listás mandátum)
  mtip int NOT NULL,
  -- Jelölt, lista egyedi azonosító
  -- (-> ejelolt.eid / tlista.tlid)
  jlid int NOT NULL,
  -- Listás jelölt sorszáma a listán
  -- (-> tlistaj.tjsorsz)
  lsorsz int NOT NULL
);
CREATE INDEX szkepv_mtip ON szkepv (mtip);
CREATE INDEX szkepv_jlid ON szkepv (jlid);
CREATE INDEX szkepv_lsorsz ON szkepv (lsorsz);

-- Számlálásra kijelölt szavazóköri névjegyzéki és megjelenési létszám adatok – „fél”-jegyzőkönyv
-- (A külképviseleteken leadott és az átjelentkezettek szavazatainak megszámlálására kijelölt
--  szavazókörök adatai)
CREATE TABLE sznapi (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Választás típusa
  -- (J: Egyéni választókerületi választás, L: Listás választás)
  valtip varchar(1) NOT NULL,
  -- Megye azonosító
  -- (-> terulet.maz)
  maz varchar(2) NOT NULL,
  -- Település sorszám megyén belül
  -- (-> telep.taz)
  taz varchar(3) NOT NULL,
  -- Szavazókör sorszám településen belül
  -- (-> szavkor.sorsz)
  sorsz varchar(3) NOT NULL,
  -- A névjegyzékben lévő helyi lakos választópolgárok száma
  a int NOT NULL,
  -- A hazai szavazókörökben szavazóként megjelentek száma
  f int NOT NULL
);
CREATE INDEX sznapi_valtip ON sznapi (valtip);
CREATE INDEX sznapi_maz ON sznapi (maz);
CREATE INDEX sznapi_taz ON sznapi (taz);
CREATE INDEX sznapi_sorsz ON sznapi (sorsz);

-- Szavazóköri jegyzőkönyv adatok (listás részletezés)
CREATE TABLE szavlf (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  --  Szavazóköri „fej” adatok egyedi azonosítója
  -- (-> szavf.jfid)
  jfid int NOT NULL,
  -- Jelölt, lista jelölés egyedi azonosító
  -- (-> ejelolt.eid / tlista.tlid)
  jlid int NOT NULL,
  -- Nemzetiség kódja
  -- (1: bolgár, 2: görög, 3: horvát, 4: lengyel, 5: német, 6: örmény, 7: roma, 8: román,
  --  9: ruszin, 10: szerb, 11: szlovák, 12: szlovén, 13: ukrán)
  nemz int NOT NULL,
  -- Választópolgárok száma a névjegyzékben
  pa int NOT NULL,
  -- Szavazókörbe tartozók közül megjelentek száma
  pf int NOT NULL,
  -- Urnában lévő bélyegzőnyomat nélküli szavazólap
  po int NOT NULL,
  -- Urnában lévő lebélyegzett szavazólap
  pk int NOT NULL,
  -- Szavazólapok száma és szavazók száma közti eltérés
  pl int NOT NULL,
  -- Érvénytelen szavazólap
  pm int NOT NULL,
  -- Érvényes szavazólap
  pn int NOT NULL
);
CREATE INDEX szavlf_jfid ON szavlf (jfid);
CREATE INDEX szavlf_jlid ON szavlf (jlid);

-- Pártdelegáltak
CREATE TABLE partdelegalt (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  id varchar(24) NOT NULL,
  -- Sorszám
  sorszm int NOT NULL,
  -- Megye
  megye varchar(22) NOT NULL,
  -- Település
  telepls varchar(20) NOT NULL,
  -- Megye azonosító
  -- (-> terulet.maz)
  maz varchar(2) NOT NULL,
  -- Település sorszám megyén belül
  -- (-> telep.taz)
  taz varchar(3) NOT NULL,
  -- Bizottság szintje
  -- (SZSZB: szavazatszámláló bizottság, HVB: helyi választási bizottság,
  --  OEVB: országgyűlési egyéni választókerületi választási bizottság,
  --  NVB: Nemzeti Választási Bizottság)
  bizottsgszintje varchar(5) NOT NULL,
  -- Szavazókör/OEVK száma
  -- (-> oevk.evk)
  szavazkroevkszma varchar(3),
  -- Szavazókör sorszám településen belül
  -- (-> szavkor.sorsz)
  sorsz varchar(3) NOT NULL,
  -- Választás napja (EEEE.HH.NN)
  vlasztsnapja varchar(10) NOT NULL,
  -- Választás típusa ("ORSZÁGGYŰLÉSI KÉPVISELŐ VÁLASZTÁS")
  vlasztstpusa varchar(33) NOT NULL,
  -- Megbízó
  -- (->  szervezet.tnev?)
  megbz varchar(44) NOT NULL,
  -- Jelölőcsoport
  jellcsoport varchar(20),
  -- Jelölőcsoport azonosító
  -- (-> jlcs.jlcs)
  jellcsopid int
);
CREATE INDEX partdelegalt_id ON partdelegalt (id);
CREATE INDEX partdelegalt_sorszm ON partdelegalt (sorszm);
CREATE INDEX partdelegalt_maz ON partdelegalt (maz);
CREATE INDEX partdelegalt_taz ON partdelegalt (taz);
CREATE INDEX partdelegalt_sorsz ON partdelegalt (sorsz);
CREATE INDEX partdelegalt_jellcsopid ON partdelegalt (jellcsopid);

-- Mandátum számítás kiinduló adatai
CREATE TABLE hatarszamf (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- 5%-os határszavazat
  hszav1 int NOT NULL,
  -- 10%-os határszavazat
  hszav2 int NOT NULL,
  -- 15%-os határszavazat
  hszav3 int NOT NULL,
  -- Kedvezményes kvóta
  hszav4 int NOT NULL
);

-- Pártok / Országos nemzetiségi önkormányzatok
CREATE TABLE szervezet (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Szervezet kód
  szkod int NOT NULL,
  -- Szervezet típusa
  -- (P: Párt (egyéni jelöltet és pártlistát állíthat),
  --  N: Országos Nemzetiségi Önkormányzat (nemzetiségi listát állíthat))
  szpntip varchar(1),
  -- Nemzetiség kódja
  -- (1: bolgár, 2: görög, 3: horvát, 4: lengyel, 5: német, 6: örmény, 7: roma, 8: román,
  --  9: ruszin, 10: szerb, 11: szlovák, 12: szlovén, 13: ukrán)
  nemz int,
  -- Szervezet hivatalos neve 1. sor
  hnev1 varchar(30) NOT NULL,
  -- Szervezet hivatalos neve 2. sor
  hnev2 varchar(30),
  -- Szervezet hivatalos neve 3. sor
  hnev3 varchar(30),
  -- Szervezet táblázatos neve
  tnev varchar(100) NOT NULL,
  -- Szervezet rövidítése
  rovid varchar(35) NOT NULL,
  -- Állapot
  -- (0: Bejelentve, 1: Nyilvántartásba véve, 2: Nyilvántartásba vétel elutasítva (nem jogerős),
  --  3: Nyilvántartásból törölve, 4: Nyilvántartásba vétel elutasítva,
  --  5: Nyilvántartásba véve (nem jogerős), 6: Nyilvántartásból törölve (nem jogerős),
  --  7: Visszalépett/visszavonva, 8: Elhunyt, 9: Választójoga megszűnt,
  --  11: Jelölő szervezete törölve, 12: Ajánlóíveket átvette,
  --  13: Ajánlóíveket nem adta le határidőben, 14: Ajánlóíveket leadta határidőben,
  --  15: Nem kíván indulni, 16: Ajánlóívet igényelt, 17: Ajánlóív igénylése elutasítva,
  --  18: Lista törölve (nem jogerős), 19: Lista törölve)
  allapot int NOT NULL,
  -- ???
  tajaz int
);
CREATE INDEX szervezet_szkod ON szervezet (szkod);
CREATE INDEX szervezet_szpntip ON szervezet (szpntip);
CREATE INDEX szervezet_rovid ON szervezet (rovid);

-- Névjegyzéki statisztikai adatok
CREATE TABLE nevjegyz (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- szavazóköri névjegyzéken és mozgóurnát igénylők jegyzékén szereplő választópolgárok száma - összesen
  nszossz int NOT NULL,
  -- szavazóköri névjegyzéken és mozgóurnát igénylők jegyzékén szereplő választópolgárok száma – egyéni jelöltre szavazhat
  nszegy int NOT NULL,
  -- szavazóköri névjegyzéken és mozgóurnát igénylők jegyzékén szereplő választópolgárok száma – pártlistára szavazhat
  nszplist int NOT NULL,
  -- szavazóköri névjegyzéken és mozgóurnát igénylők jegyzékén szereplő választópolgárok száma – nemzetiségi listára szavazhat
  nsznemz int NOT NULL,
  -- külképviseleti névjegyzéken szereplő választópolgárok száma – összesen
  nkossz int NOT NULL,
  -- külképviseleti névjegyzéken szereplő választópolgárok száma – egyéni jelöltre szavazhat
  nkegyeni int NOT NULL,
  -- külképviseleti névjegyzéken szereplő választópolgárok száma – pártlistára szavazhat
  nkplist int NOT NULL,
  -- külképviseleti névjegyzéken szereplő választópolgárok száma – nemzetiségi listára szavazhat
  nknemz int NOT NULL,
  -- Átjelentkezett választópolgárok névjegyzékén szereplő választópolgárok száma - összesen
  naossz int NOT NULL,
  -- Átjelentkezett választópolgárok névjegyzékén szereplő választópolgárok száma - egyéni jelöltre szavazhat
  naegyeni int NOT NULL,
  -- Átjelentkezett választópolgárok névjegyzékén szereplő választópolgárok száma - pártlistára szavazhat
  naplist int NOT NULL,
  -- Átjelentkezett választópolgárok névjegyzékén szereplő választópolgárok száma - nemzetiségi listára szavazhat
  nanemz int NOT NULL,
  -- Levélben szavazó választópolgárok névjegyzékén szereplők száma
  nlsz int NOT NULL,
  -- Nemzetiségi választópolgárok száma - összesen
  nnossz int NOT NULL,
  -- Nemzetiségi választópolgárok száma - bolgár
  nbolgar int NOT NULL,
  -- Nemzetiségi választópolgárok száma - görög
  ngorog int NOT NULL,
  -- Nemzetiségi választópolgárok száma - horvát
  nhorvat int NOT NULL,
  -- Nemzetiségi választópolgárok száma - lengyel
  nlengyel int NOT NULL,
  -- Nemzetiségi választópolgárok száma - német
  nnemet int NOT NULL,
  -- Nemzetiségi választópolgárok száma - örmény
  normeny int NOT NULL,
  -- Nemzetiségi választópolgárok száma - roma
  nroma int NOT NULL,
  -- Nemzetiségi választópolgárok száma - román
  nroman int NOT NULL,
  -- Nemzetiségi választópolgárok száma - ruszin
  nruszin int NOT NULL,
  -- Nemzetiségi választópolgárok száma - szerb
  nszerb int NOT NULL,
  -- Nemzetiségi választópolgárok száma - szlovák
  nszlovak int NOT NULL,
  -- Nemzetiségi választópolgárok száma - szlovén
  nszloven int NOT NULL,
  -- Nemzetiségi választópolgárok száma - ukrán
  nukran int NOT NULL
);

-- Szavazásnapi névjegyzéki listás tétel adatok az átjelentkezéssel és a külföldön leadott
-- szavazatok megszámlálására kijelölt szavazókörből
CREATE TABLE sznapilf (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Választás típusa
  -- (J: Egyéni választókerületi választás, L: Listás választás)
  valtip varchar(1) NOT NULL,
  -- Megye azonosító
  -- (-> terulet.maz)
  maz varchar(2) NOT NULL,
  -- Település sorszám megyén belül
  -- (-> telep.taz)
  taz varchar(3) NOT NULL,
  -- Szavazókör sorszám településen belül
  -- (-> szavkor.sorsz)
  sorsz varchar(3) NOT NULL,
  -- Nemzetiség kódja
  -- (1: bolgár, 2: görög, 3: horvát, 4: lengyel, 5: német, 6: örmény, 7: roma, 8: román,
  --  9: ruszin, 10: szerb, 11: szlovák, 12: szlovén, 13: ukrán)
  nemz int NOT NULL,
  -- A szavazóköri névjegyzékben és a mozgóurnát igénylő választópolgárok jegyzékében listára szavazó választópolgárok száma
  a int NOT NULL,
  -- A szavazóhelységben és a mozgóurnával szavazó (megjelent) választópolgárok száma
  f int NOT NULL
);
CREATE INDEX sznapilf_valtip ON sznapilf (valtip);
CREATE INDEX sznapilf_maz ON sznapilf (maz);
CREATE INDEX sznapilf_taz ON sznapilf (taz);
CREATE INDEX sznapilf_sorsz ON sznapilf (sorsz);

-- Országos listák
CREATE TABLE tlista (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Országos lista egyedi azonosító
  tlid int NOT NULL,
  -- Lista típusa
  -- (O: Önálló lista, K: Közös lista, N: Nemzetiségi lista)
  ltip varchar(1) NOT NULL,
  -- Nemzetiség kódja
  -- (1: bolgár, 2: görög, 3: horvát, 4: lengyel, 5: német, 6: örmény, 7: roma, 8: román,
  --  9: ruszin, 10: szerb, 11: szlovák, 12: szlovén, 13: ukrán)
  nemz int,
  -- Listát állító JLCS kódja
  -- (-> jlcs.jlcs)
  jlcs int NOT NULL,
  -- Listaállító párt, országos nemzetiségi önkormányzat neve
  tnev varchar(100) NOT NULL,
  -- Lista sorszáma a szavazólapon
  -- (NULL: nem szerepel, 1: kisebbségi önkormányzatok)
  sorsz int,
  -- Lista érvényesen szerepel a szavazólapon jelző
  -- (0: Szavazólapon nem szerepel, 1: Szerepel a szavazólapon,
  --  2: Szerepel a szavazólapon, de érvénytelenül)
  erv int NOT NULL,
  -- Lista állapota
  -- Jelölt állapota
  -- (0: Bejelentve, 1: Nyilvántartásba véve, 2: Nyilvántartásba vétel elutasítva (nem jogerős),
  --  3: Nyilvántartásból törölve, 4: Nyilvántartásba vétel elutasítva,
  --  5: Nyilvántartásba véve (nem jogerős), 6: Nyilvántartásból törölve (nem jogerős),
  --  7: Visszalépett/visszavonva, 8: Elhunyt, 9: Választójoga megszűnt,
  --  11: Jelölő szervezete törölve, 12: Ajánlóíveket átvette,
  --  13: Ajánlóíveket nem adta le határidőben, 14: Ajánlóíveket leadta határidőben,
  --  15: Nem kíván indulni, 16: Ajánlóívet igényelt, 17: Ajánlóív igénylése elutasítva,
  --  18: Lista törölve (nem jogerős), 19: Lista törölve)
  allapot int NOT NULL
);
CREATE INDEX tlista_tlid ON tlista (tlid);
CREATE INDEX tlista_ltip ON tlista (ltip);
CREATE INDEX tlista_jlcs ON tlista (jlcs);
CREATE INDEX tlista_sorsz ON tlista (sorsz);

-- OEVK-k (Országgyűlési Egyéni Választókerületek)
CREATE TABLE oevk (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Megye azonosító
  -- (-> terulet.maz)
  maz varchar(2) NOT NULL,
  -- OEVK sorszám megyén belül
  evk varchar(2) NOT NULL,
  -- OEVK székhely település neve
  szekh varchar(17) NOT NULL,
  -- OEVK székhely település budapesti kerülete
  szekhk varchar(2)
);
CREATE INDEX oevk_maz ON oevk (maz);

-- Szavazóköri szavazási „tétel” adatok
CREATE TABLE szavt (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Szavazóköri „fej” adatok egyedi azonosítója
  -- (-> szavf.jfid)
  jfid int NOT NULL,
  -- Jelölt, lista jelölés egyedi azonosító
  -- (-> ejelolt.eid / tlista.tlid)
  jlid int NOT NULL,
  -- Kapott szavazat
  szav int NOT NULL
);
CREATE INDEX szavt_jfid ON szavt (jfid);
CREATE INDEX szavt_jlid ON szavt (jlid);

-- Szavazóköri szavazási „fej” adatok
CREATE TABLE szavf (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Szavazóköri „fej” adatok egyedi azonosítója
  jfid int NOT NULL,
  -- Választás típusa
  -- (J: Egyéni választókerületi választás, L: Listás választás)
  valtip varchar(1) NOT NULL,
  -- Megye azonosító
  -- (-> terulet.maz)
  maz varchar(2) NOT NULL,
  -- Település sorszám megyén belül
  -- (-> telep.taz)
  taz varchar(3),
  -- Szavazókör sorszám településen belül
  -- (-> szavkor.sorsz)
  sorsz varchar(3),
  -- A névjegyzékben lévő helyi lakos választópolgárok száma
  a int NOT NULL,
  -- Az átjelentkezett (máshol szavazó) választópolgárok száma
  b int NOT NULL,
  -- Átjelentkezéssel szavazó választópolgárok száma a névjegyzéken (ahol szavaznak)
  bo int NOT NULL,
  -- A külképviseleteken szavazó választópolgárok száma
  c int NOT NULL,
  -- A levélben szavazók névjegyzékében szereplő választópolgárok száma
  d int NOT NULL,
  -- Választópolgárok száma összesen
  e int NOT NULL,
  -- A hazai szavazókörökben szavazóként megjelentek száma
  f int NOT NULL,
  -- A hazai szavazókörökben átjelentkezés alapján szavazóként megjelentek száma
  g int NOT NULL,
  -- Egy szavazókörös és kijelölt szavazókörök esetén az urnában lévő átjelentkezéssel szavazók szavazatait tartalmazó borítékok száma
  i1 int NOT NULL,
  -- Számlálásra kijelölt szavazókörök esetén az átjelentkezettek és külképviseleten szavazók szavazatait tartalmazó borítékok száma
  i2 int NOT NULL,
  -- Levélben szavazás esetén a levélben szavazók szavazatait tartalmazó érvényes szavazási iratok száma
  i3 int NOT NULL,
  -- Szavazatot leadók száma összesen
  j int NOT NULL,
  -- Lebélyegző lenyomat nélküli szavazólapok száma
  o int NOT NULL,
  -- Lebélyegzett szavazólapok száma
  k1 int NOT NULL,
  -- Levélben szavazás esetén érvényes szavazási iratokban lévő szavazólapok száma
  k2 int NOT NULL,
  -- Eltérés a szavazóként megjelentek számától ±
  l int NOT NULL,
  -- Érvénytelen szavazólapok száma
  m int NOT NULL,
  -- Érvényes szavazólapok száma
  n int NOT NULL,
  -- U.a. csak pártlistára
  pa int NOT NULL,
  pf int NOT NULL,
  po int NOT NULL,
  pk int NOT NULL,
  pl int NOT NULL,
  pm int NOT NULL,
  pn int NOT NULL,
  -- U.a. csak nemzetiségi listára
  na int NOT NULL,
  nf int NOT NULL,
  no int NOT NULL,
  nk int NOT NULL,
  nl int NOT NULL,
  nm int NOT NULL,
  nn int NOT NULL
);
CREATE INDEX szavf_jfid ON szavf (jfid);
CREATE INDEX szavf_valtip ON szavf (valtip);
CREATE INDEX szavf_maz ON szavf (maz);
CREATE INDEX szavf_taz ON szavf (taz);
CREATE INDEX szavf_sorsz ON szavf (sorsz);

-- Jelölőcsoportok tagszervezetei
CREATE TABLE jlcstag (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Jelölőcsoport kód
  -- (-> jlcs.jlcs)
  jlcs int NOT NULL,
  -- Jelölőcsoport tagszervezet kód
  -- (-> szervezet.szkod)
  szkod int NOT NULL,
  -- Tagszervezet sorszáma a jelölőcsoporton belül
  sorsz int NOT NULL
);
CREATE INDEX jlcstag_jlcs ON jlcstag (jlcs);
CREATE INDEX jlcstag_szkod ON jlcstag (szkod);
CREATE INDEX jlcstag_sorsz ON jlcstag (sorsz);

-- Összesített adatok szavazási „fej” adatai listás, illetve egyéni választókerületi választás esetén
CREATE TABLE szeredmf (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Összesítő tétel egyedi azonosító
  sfid int NOT NULL,
  -- Összesítési szint
  -- (1: Egyéni választókerületi adatok, 4: Megyei, fővárosi összesített adatok,
  --  51: Országosan összesített listás szavazatok (Mo. + külképviselet + levélben),
  --  52: Országosan összesített listás szavazatok (Mo. + külképviselet),
  --  53: Listás szavazatok (levélben))
  oszint int NOT NULL,
  -- Megye azonosító
  -- (-> terulet.maz)
  sfmaz varchar(2),
  -- OEVK sorszám megyén belül
  -- (-> oevk.evk)
  sfevk varchar(2),
  -- Választás típusa
  -- (J: Egyéni választókerületi választás, L: Listás választás)
  valtip varchar(1) NOT NULL,
  -- Adat forrás jelző
  -- (0: Előzetes adat, 1: Jegyzőkönyvi adat, 4: Megsemmisített jegyzőkönyvi adat)
  forr int NOT NULL,
  -- Végleges jogi állapot (I/N)
  jogi varchar(1) NOT NULL,
  -- Eredményességi kiértékelés
  -- (0: Nincs értékelhető adat, 1: Eredményes választás, 2: Eredménytelen választás)
  eredm int NOT NULL,
  -- A névjegyzékben lévő helyi lakos választópolgárok száma
  a int NOT NULL,
  -- Az átjelentkezett (máshol szavazó) választópolgárok száma
  b int NOT NULL,
  -- A külképviseleti névjegyzékben szereplő választópolgárok száma
  c int NOT NULL,
  -- A levélben szavazók névjegyzékében szereplő választópolgárok száma
  d int NOT NULL,
  -- Választópolgárok száma összesen
  e int NOT NULL,
  -- Szavazókörökben szavazóként megjelentek száma
  f int NOT NULL,
  -- Egyéni választókerületi szavazás - átjelentkezettek, külképviseleten szavazók szavazatait tartalmazó borítékok száma
  ie int NOT NULL,
  -- Listás szavazás - átjelentkezettek, külképviseleten, levélben szavazók szavazatait tartalmazó (érvényes) borítékok száma
  ilis int NOT NULL,
  -- Levélben szavazás - levélben szavazók szavazatait tartalmazó (érvényes) szavazási iratok száma
  ilev int NOT NULL,
  -- Szavazatot leadók száma
  j int NOT NULL,
  -- Egyéni választókerületi szavazás - urnában és borítékokban lévő szavazólapok száma
  ke int NOT NULL,
  -- Listás + levélben szavazás - urnában és boritékokban lévő lebélyegzett szavazólapok száma
  klis int NOT NULL,
  -- Érvénytelen szavazólapok száma
  m int NOT NULL,
  -- Érvényes szavazólapok száma
  n int NOT NULL,
  -- Beérkezett jegyzőkönyvek száma
  jojkv int NOT NULL,
  -- Feldolgozási %
  feldar varchar(5) NOT NULL,
  -- Levélben szavazásnál a szavazási iratok ellenőrzésének készültségi %-a
  levell varchar(5) NOT NULL,
  -- Levélben szavazásnál a szavazólapok feldolgozásának készültségi %-a
  levszl int NOT NULL,
  -- Mandátumot szerző egyéni jelölt jelölésének egyedi azonosítója (OEVK-ban)
  -- (-> ejelolt.eid)
  eid int
);
CREATE INDEX szeredmf_sfid ON szeredmf (sfid);
CREATE INDEX szeredmf_sfmaz ON szeredmf (sfmaz);
CREATE INDEX szeredmf_valtip ON szeredmf (valtip);
CREATE INDEX szeredmf_eid ON szeredmf (eid);

-- Megyék
CREATE TABLE terulet (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Megye azonosító (sorszám)
  maz varchar(2) NOT NULL,
  -- Megye név
  mnev varchar(22) NOT NULL,
  -- Megye rövid név
  mrnev varchar(10) NOT NULL
);
CREATE INDEX terulet_maz ON terulet (maz);

-- Az állományokban használt kódok leírása
CREATE TABLE kodok (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Kódcsoport azonosító
  kodcsop varchar(9) NOT NULL,
  -- Kód
  kod varchar(2) NOT NULL,
  -- Kód megnevezése
  szoveg varchar(73) NOT NULL
);
CREATE INDEX kodok_kodcsop ON kodok (kodcsop);
CREATE INDEX kodok_kod ON kodok (kod);

-- Összesített adatok szavazási „tétel” adatai listás, illetve egyéni választókerületi választás esetén
CREATE TABLE szeredmt (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Összesítő tétel egyedi azonosító
  -- (-> szeredmf.sfid)
  sfid int NOT NULL,
  -- Jelölt, lista jelölésének egyedi azonosítója
  -- (-> ejelolt.eid / tlista.tlid)
  jlid int NOT NULL,
  -- Kapott szavazat
  szav int NOT NULL,
  -- Töredékszavazatok száma pártlisták esetén
  torsz int NOT NULL,
  -- Mandátum számításnál figyelembe vehető szavazat (töredékszavazattal növelt, illetve kedvezményes kvótával csökkentett)
  mandszav int NOT NULL,
  -- Lista kaphat-e mandátumot jelző
  -- (0: Nem történt mandátum számítás, 1: Mandátumot kaphat, 2: Mandátumot nem kaphat)
  hatar int NOT NULL,
  -- Lista kapott mandátumainak száma
  mand int NOT NULL
);
CREATE INDEX szeredmt_sfid ON szeredmt (sfid);
CREATE INDEX szeredmt_jlid ON szeredmt (jlid);

-- Jelölőcsoport tagszervezetei megjelenítési sorrendje
CREATE TABLE jlcssor (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Jelölés típusa jelző
  -- (J: Egyéni választókerületi választás, L: Listás választás)
  tip varchar(1) NOT NULL,
  -- Jelölés egyedi azonosító
  -- (-> ejelolt.eid / tlista.tlid)
  id int NOT NULL,
  -- A szervezet JLCS-n belüli megjelenítési sorrendje a jelölés típus szerinti jelölésben
  sorsz int NOT NULL,
  -- Szervezet kód
  -- (-> szervezet.szkod)
  szkod int NOT NULL
);
CREATE INDEX jlcssor_tip ON jlcssor (tip);
CREATE INDEX jlcssor_id ON jlcssor (id);
CREATE INDEX jlcssor_sorsz ON jlcssor (sorsz);
CREATE INDEX jlcssor_szkod ON jlcssor (szkod);

-- Települések
CREATE TABLE telep (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Megye azonosító
  -- (-> terulet.maz)
  maz varchar(2) NOT NULL,
  -- Település sorszám megyén belül
  taz varchar(3) NOT NULL,
  -- Település neve (kerület római számmal)
  tnevi varchar(23) NOT NULL,
  -- Település neve (kerület nélkül)
  tnev varchar(20) NOT NULL,
  -- Település kerülete arab számmal
  tker varchar(2),
  -- Település típusa
  -- (1: Fővárosi kerület, 2: Megyei jogú város, 3: Város, Község)
  ttip int NOT NULL
);
CREATE INDEX telep_maz ON telep (maz);
CREATE INDEX telep_taz ON telep (taz);
CREATE INDEX telep_ttip ON telep (ttip);

-- Jelölő, listát állító jelölőcsoportok
-- (pártok + 0 = független)
CREATE TABLE jlcs (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Jelölőcsoport kód
  -- (-> jlcs.jlcs)
  jlcs int NOT NULL,
  -- Jelölő csoport táblázatos neve
  nevt varchar(28) NOT NULL,
  -- Jelölő csoport tagjainak száma
  tag int NOT NULL
);
CREATE INDEX jlcs_jlcs ON jlcs (jlcs);

-- Vezérlő adatok
-- (csak egy rekord van benne, ami az adatbázis jelenlegi állapotának jellemzése)
CREATE TABLE verzio (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Verziókészítés dátuma, ideje
  -- EEEE.HH.NN.OO:PP:MM
  ver varchar(19) NOT NULL,
  -- Állomány típusa
  -- (1: Törzsadatok, 2: Napközbeni jelentések adatai, 3: Szavazatösszesítési adatok)
  tjel int NOT NULL,
  -- Országos listás mandátumosztás megtörtént jelző (0/1)
  eng1 int NOT NULL,
  -- Mandátumok személyhez rendelése megtörtént jelző (0/1)
  eng2 int NOT NULL,
  -- Országos feldolgozottsági %: szavazóköri adatok beérkezése
  feldar varchar(5) NOT NULL,
  -- Levélben szavazásnál a szavazási iratok ellenőrzésének készültségi %-a
  levell varchar(5) NOT NULL,
  -- Levélben szavazásnál a szavazólapok feldolgozásának készültségi %-a
  levszl int NOT NULL
);

-- Szavazókörök
CREATE TABLE szavkor (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Megye azonosító
  -- (-> terulet.maz)
  maz varchar(2) NOT NULL,
  -- Település sorszám megyén belül
  -- (-> telep.maz)
  taz varchar(3),
  -- Szavazókör sorszám településen belül
  sorsz varchar(3),
  -- Szavazókör OEVK besorolása
  -- (-> oevk.evk)
  evk varchar(2),
  -- Szavazókör típusa
  -- (1: Normál szavazókör, 2: Településszintű lakosok és átjelentkezettek szavazására (is) kijelölt,
  --  3: A külképviseleteken és átjelentkezéssel szavazók szavazatainak megszámlálására (is) kijelölt,
  --  4: A levélben szavazás eredményét jelző technikai szavazókör)
  tip int NOT NULL,
  -- Szavazókör címe – település név
  cimt varchar(20) NOT NULL,
  -- Szavazókör településen belüli közismert címe
  cimk varchar(50) NOT NULL
);
CREATE INDEX szavkor_maz ON szavkor (maz);
CREATE INDEX szavkor_taz ON szavkor (taz);
CREATE INDEX szavkor_sorsz ON szavkor (sorsz);
CREATE INDEX szavkor_tip ON szavkor (tip);

-- Egyéni jelöltek
CREATE TABLE ejelolt (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Megye azonosító
  -- (-> terulet.maz)
  maz varchar(2) NOT NULL,
  -- OEVK sorszám megyén belül
  -- (oevk.evk)
  evk varchar(2) NOT NULL,
  -- Egyéni jelölés egyedi azonosító
  eid int NOT NULL,
  -- Jelölt személy egyedi azonosítója a választáson
  tajaz varchar(40) NOT NULL,
  -- Jelölt nevének dr. jelzője
  dr varchar(3),
  -- Dr. jelző a szavazólapon megjelenítendő (I/N)
  drjel varchar(1),
  -- Jelölt családi neve
  nev varchar(50) NOT NULL,
  -- Jelölt első utóneve
  unev1 varchar(20) NOT NULL,
  -- Jelölt második utóneve
  unev2 varchar(20),
  -- 2 utónév esetén melyik utónevet kell megjeleníteni (1/2, NULL: mindkettő)
  unevjel int,
  -- Jelöltet állító JLCS kódja
  -- (jlcs.jlcs)
  jlcs int NOT NULL,
  -- Jelölt szavazólapi sorszáma (NULL: nem szerepel a szavazólapon)
  sorsz int,
  -- Jelölt érvényesen szerepel a szavazólapon jelző
  -- (0: Szavazólapon nem szerepel, 1: Szerepel a szavazólapon,
  --  2: Szerepel a szavazólapon, de érvénytelenül)
  erv int NOT NULL,
  -- Jelölt állapota
  -- (0: Bejelentve, 1: Nyilvántartásba véve, 2: Nyilvántartásba vétel elutasítva (nem jogerős),
  --  3: Nyilvántartásból törölve, 4: Nyilvántartásba vétel elutasítva,
  --  5: Nyilvántartásba véve (nem jogerős), 6: Nyilvántartásból törölve (nem jogerős),
  --  7: Visszalépett/visszavonva, 8: Elhunyt, 9: Választójoga megszűnt,
  --  11: Jelölő szervezete törölve, 12: Ajánlóíveket átvette,
  --  13: Ajánlóíveket nem adta le határidőben, 14: Ajánlóíveket leadta határidőben,
  --  15: Nem kíván indulni, 16: Ajánlóívet igényelt, 17: Ajánlóív igénylése elutasítva,
  --  18: Lista törölve (nem jogerős), 19: Lista törölve)
  allapot int NOT NULL,
  -- Fénykép azonosító
  fenykep int
);
CREATE INDEX ejelolt_maz ON ejelolt (maz);
CREATE INDEX ejelolt_eid ON ejelolt (eid);
CREATE INDEX ejelolt_jlcs ON ejelolt (jlcs);
CREATE INDEX ejelolt_sorsz ON ejelolt (sorsz);

-- Országos listák jelöltjei
CREATE TABLE tlistaj (
  internal_id INTEGER PRIMARY KEY NOT NULL,
  -- Országos lista egyedi azonosító
  -- (-> tlista.tlid)
  tlid int NOT NULL,
  -- Jelölt sorszáma a listán
  tjsorsz int NOT NULL,
  -- Jelölt személy egyedi azonosítója a választáson
  tajaz varchar(40) NOT NULL,
  -- Jelölt nevének dr. jelzője
  dr varchar(3),
  -- Dr. jelző a szavazólapon megjelenítendő (I/N)
  drjel varchar(1),
  -- Jelölt családi neve
  nev varchar(50) NOT NULL,
  -- Jelölt első utóneve
  unev1 varchar(20) NOT NULL,
  -- Jelölt második utóneve
  unev2 varchar(20),
  -- 2 utónév esetén melyik utónevet kell megjeleníteni (1/2, NULL: mindkettő)
  unevjel int,
  -- Jelölt állapota
  -- (0: Bejelentve, 1: Nyilvántartásba véve, 2: Nyilvántartásba vétel elutasítva (nem jogerős),
  --  3: Nyilvántartásból törölve, 4: Nyilvántartásba vétel elutasítva,
  --  5: Nyilvántartásba véve (nem jogerős), 6: Nyilvántartásból törölve (nem jogerős),
  --  7: Visszalépett/visszavonva, 8: Elhunyt, 9: Választójoga megszűnt,
  --  11: Jelölő szervezete törölve, 12: Ajánlóíveket átvette,
  --  13: Ajánlóíveket nem adta le határidőben, 14: Ajánlóíveket leadta határidőben,
  --  15: Nem kíván indulni, 16: Ajánlóívet igényelt, 17: Ajánlóív igénylése elutasítva,
  --  18: Lista törölve (nem jogerős), 19: Lista törölve)
  allapot int NOT NULL,
  -- Fénykép azonosító
  fenykep int
);
CREATE INDEX tlistaj_tlid ON tlistaj (tlid);
CREATE INDEX tlistaj_tjsorsz ON tlistaj (tjsorsz);
