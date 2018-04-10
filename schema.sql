CREATE TABLE szkepv (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  mtip int NOT NULL,
  jlid int NOT NULL,
  lsorsz int NOT NULL
);
CREATE INDEX szkepv_jlid ON szkepv (jlid);
CREATE INDEX szkepv_lsorsz ON szkepv (lsorsz);

CREATE TABLE sznapi (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  valtip varchar(1) NOT NULL,
  maz varchar(2) NOT NULL,
  taz varchar(3) NOT NULL,
  sorsz varchar(3) NOT NULL,
  a int NOT NULL,
  f int NOT NULL
);
CREATE INDEX sznapi_sorsz ON sznapi (sorsz);

CREATE TABLE szavlf (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  jfid int NOT NULL,
  jlid int NOT NULL,
  nemz int NOT NULL,
  pa int NOT NULL,
  pf int NOT NULL,
  po int NOT NULL,
  pk int NOT NULL,
  pl int NOT NULL,
  pm int NOT NULL,
  pn int NOT NULL
);
CREATE INDEX szavlf_jfid ON szavlf (jfid);
CREATE INDEX szavlf_jlid ON szavlf (jlid);

CREATE TABLE partdelegalt (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  id varchar(24) NOT NULL,
  sorszm int NOT NULL,
  megye varchar(22) NOT NULL,
  telepls varchar(20) NOT NULL,
  bizottsgszintje varchar(5) NOT NULL,
  szavazkroevkszma varchar(3),
  vlasztsnapja varchar(10) NOT NULL,
  vlasztstpusa varchar(33) NOT NULL,
  megbz varchar(44) NOT NULL,
  jellcsoport varchar(20),
  jellcsopid int
);
CREATE INDEX partdelegalt_id ON partdelegalt (id);
CREATE INDEX partdelegalt_sorszm ON partdelegalt (sorszm);
CREATE INDEX partdelegalt_jellcsopid ON partdelegalt (jellcsopid);

CREATE TABLE hatarszamf (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  hszav1 int NOT NULL,
  hszav2 int NOT NULL,
  hszav3 int NOT NULL,
  hszav4 int NOT NULL
);

CREATE TABLE szervezet (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  szkod int NOT NULL,
  szpntip varchar(1),
  nemz int,
  hnev1 varchar(30) NOT NULL,
  hnev2 varchar(28),
  hnev3 varchar(8),
  tnev varchar(63) NOT NULL,
  rovid varchar(35) NOT NULL,
  allapot int NOT NULL,
  tajaz int
);
CREATE INDEX szervezet_szkod ON szervezet (szkod);
CREATE INDEX szervezet_rovid ON szervezet (rovid);

CREATE TABLE nevjegyz (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nszossz int NOT NULL,
  nszegy int NOT NULL,
  nszplist int NOT NULL,
  nsznemz int NOT NULL,
  nkossz int NOT NULL,
  nkegyeni int NOT NULL,
  nkplist int NOT NULL,
  nknemz int NOT NULL,
  naossz int NOT NULL,
  naegyeni int NOT NULL,
  naplist int NOT NULL,
  nanemz int NOT NULL,
  nlsz int NOT NULL,
  nnossz int NOT NULL,
  nbolgar int NOT NULL,
  ngorog int NOT NULL,
  nhorvat int NOT NULL,
  nlengyel int NOT NULL,
  nnemet int NOT NULL,
  normeny int NOT NULL,
  nroma int NOT NULL,
  nroman int NOT NULL,
  nruszin int NOT NULL,
  nszerb int NOT NULL,
  nszlovak int NOT NULL,
  nszloven int NOT NULL,
  nukran int NOT NULL
);

CREATE TABLE sznapilf (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  valtip varchar(1) NOT NULL,
  maz varchar(2) NOT NULL,
  taz varchar(3) NOT NULL,
  sorsz varchar(3) NOT NULL,
  nemz int NOT NULL,
  a int NOT NULL,
  f int NOT NULL
);
CREATE INDEX sznapilf_sorsz ON sznapilf (sorsz);

CREATE TABLE tlista (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  tlid int NOT NULL,
  ltip varchar(1) NOT NULL,
  nemz int,
  jlcs int NOT NULL,
  tnev varchar(19) NOT NULL,
  sorsz int,
  erv int NOT NULL,
  allapot int NOT NULL
);
CREATE INDEX tlista_tlid ON tlista (tlid);
CREATE INDEX tlista_sorsz ON tlista (sorsz);

CREATE TABLE oevk (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  maz varchar(2) NOT NULL,
  evk varchar(2) NOT NULL,
  szekh varchar(17) NOT NULL,
  szekhk varchar(2)
);

CREATE TABLE szavt (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  jfid int NOT NULL,
  jlid int NOT NULL,
  szav int NOT NULL
);
CREATE INDEX szavt_jfid ON szavt (jfid);
CREATE INDEX szavt_jlid ON szavt (jlid);

CREATE TABLE szavf (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  jfid int NOT NULL,
  valtip varchar(1) NOT NULL,
  maz varchar(2) NOT NULL,
  taz varchar(3),
  sorsz varchar(3),
  a int NOT NULL,
  b int NOT NULL,
  bo int NOT NULL,
  c int NOT NULL,
  d int NOT NULL,
  e int NOT NULL,
  f int NOT NULL,
  g int NOT NULL,
  i1 int NOT NULL,
  i2 int NOT NULL,
  i3 int NOT NULL,
  j int NOT NULL,
  o int NOT NULL,
  k1 int NOT NULL,
  k2 int NOT NULL,
  l int NOT NULL,
  m int NOT NULL,
  n int NOT NULL,
  pa int NOT NULL,
  pf int NOT NULL,
  po int NOT NULL,
  pk int NOT NULL,
  pl int NOT NULL,
  pm int NOT NULL,
  pn int NOT NULL,
  na int NOT NULL,
  nf int NOT NULL,
  no int NOT NULL,
  nk int NOT NULL,
  nl int NOT NULL,
  nm int NOT NULL,
  nn int NOT NULL
);
CREATE INDEX szavf_jfid ON szavf (jfid);
CREATE INDEX szavf_sorsz ON szavf (sorsz);

CREATE TABLE jlcstag (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  jlcs int NOT NULL,
  szkod int NOT NULL,
  sorsz int NOT NULL
);
CREATE INDEX jlcstag_szkod ON jlcstag (szkod);
CREATE INDEX jlcstag_sorsz ON jlcstag (sorsz);

CREATE TABLE szeredmf (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  sfid int NOT NULL,
  oszint int NOT NULL,
  sfmaz varchar(2),
  sfevk varchar(2),
  valtip varchar(1) NOT NULL,
  forr int NOT NULL,
  jogi varchar(1) NOT NULL,
  eredm int NOT NULL,
  a int NOT NULL,
  b int NOT NULL,
  c int NOT NULL,
  d int NOT NULL,
  e int NOT NULL,
  f int NOT NULL,
  ie int NOT NULL,
  ilis int NOT NULL,
  ilev int NOT NULL,
  j int NOT NULL,
  ke int NOT NULL,
  klis int NOT NULL,
  m int NOT NULL,
  n int NOT NULL,
  jojkv int NOT NULL,
  feldar varchar(5) NOT NULL,
  levell varchar(5) NOT NULL,
  levszl int NOT NULL,
  eid int
);
CREATE INDEX szeredmf_sfid ON szeredmf (sfid);
CREATE INDEX szeredmf_eid ON szeredmf (eid);

CREATE TABLE terulet (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  maz varchar(2) NOT NULL,
  mnev varchar(22) NOT NULL,
  mrnev varchar(10) NOT NULL
);

CREATE TABLE kodok (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  kodcsop varchar(9) NOT NULL,
  kod varchar(2) NOT NULL,
  szoveg varchar(73) NOT NULL
);
CREATE INDEX kodok_kodcsop ON kodok (kodcsop);
CREATE INDEX kodok_kod ON kodok (kod);

CREATE TABLE szeredmt (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  sfid int NOT NULL,
  jlid int NOT NULL,
  szav int NOT NULL,
  torsz int NOT NULL,
  mandszav int NOT NULL,
  hatar int NOT NULL,
  mand int NOT NULL
);
CREATE INDEX szeredmt_sfid ON szeredmt (sfid);
CREATE INDEX szeredmt_jlid ON szeredmt (jlid);

CREATE TABLE jlcssor (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  tip varchar(1) NOT NULL,
  id int NOT NULL,
  sorsz int NOT NULL,
  szkod int NOT NULL
);
CREATE INDEX jlcssor_id ON jlcssor (id);
CREATE INDEX jlcssor_sorsz ON jlcssor (sorsz);
CREATE INDEX jlcssor_szkod ON jlcssor (szkod);

CREATE TABLE telep (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  maz varchar(2) NOT NULL,
  taz varchar(3) NOT NULL,
  tnevi varchar(23) NOT NULL,
  tnev varchar(20) NOT NULL,
  tker varchar(2),
  ttip int NOT NULL
);

CREATE TABLE jlcs (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  jlcs int NOT NULL,
  nevt varchar(28) NOT NULL,
  tag int NOT NULL
);

CREATE TABLE verzio (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ver varchar(19) NOT NULL,
  tjel int NOT NULL,
  eng1 int NOT NULL,
  eng2 int NOT NULL,
  feldar varchar(5) NOT NULL,
  levell varchar(5) NOT NULL,
  levszl int NOT NULL
);

CREATE TABLE szavkor (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  maz varchar(2) NOT NULL,
  taz varchar(3),
  sorsz varchar(3),
  evk varchar(2),
  tip int NOT NULL,
  cimt varchar(20) NOT NULL,
  cimk varchar(50) NOT NULL
);
CREATE INDEX szavkor_sorsz ON szavkor (sorsz);

CREATE TABLE ejelolt (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  maz varchar(2) NOT NULL,
  evk varchar(2) NOT NULL,
  eid int NOT NULL,
  tajaz varchar(32) NOT NULL,
  dr varchar(3),
  drjel varchar(1),
  nev varchar(24) NOT NULL,
  unev1 varchar(13) NOT NULL,
  unev2 varchar(11),
  unevjel int,
  jlcs int NOT NULL,
  sorsz int,
  erv int NOT NULL,
  allapot int NOT NULL,
  fenykep int
);
CREATE INDEX ejelolt_eid ON ejelolt (eid);
CREATE INDEX ejelolt_sorsz ON ejelolt (sorsz);

CREATE TABLE tlistaj (
  internal_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  tlid int NOT NULL,
  tjsorsz int NOT NULL,
  tajaz varchar(32) NOT NULL,
  dr varchar(3),
  drjel varchar(1),
  nev varchar(24) NOT NULL,
  unev1 varchar(11) NOT NULL,
  unev2 varchar(11),
  unevjel int,
  allapot int NOT NULL,
  fenykep int
);
CREATE INDEX tlistaj_tlid ON tlistaj (tlid);
CREATE INDEX tlistaj_tjsorsz ON tlistaj (tjsorsz);
