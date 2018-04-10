CREATE TABLE szkepv (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  mtip int NOT NULL,
  jlid int NOT NULL,
  lsorsz varchar(2) NOT NULL
);
CREATE INDEX szkepv_jlid ON szkepv (jlid);
CREATE INDEX szkepv_lsorsz ON szkepv (lsorsz);

CREATE TABLE sznapi (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  valtip varchar(1) NOT NULL,
  maz varchar(2) NOT NULL,
  taz varchar(3) NOT NULL,
  sorsz varchar(3) NOT NULL,
  a int NOT NULL,
  f int NOT NULL
);
CREATE INDEX sznapi_sorsz ON sznapi (sorsz);

CREATE TABLE szavlf (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  jfid int NOT NULL,
  jlid int NOT NULL,
  nemz int NOT NULL,
  pa varchar(3) NOT NULL,
  pf varchar(3) NOT NULL,
  po varchar(1) NOT NULL,
  pk varchar(3) NOT NULL,
  pl varchar(2) NOT NULL,
  pm varchar(2) NOT NULL,
  pn varchar(3) NOT NULL
);
CREATE INDEX szavlf_jfid ON szavlf (jfid);
CREATE INDEX szavlf_jlid ON szavlf (jlid);

CREATE TABLE hatarszamf (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  hszav1 int NOT NULL,
  hszav2 int NOT NULL,
  hszav3 int NOT NULL,
  hszav4 int NOT NULL
);

CREATE TABLE szervezet (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  szkod varchar(4) NOT NULL,
  szpntip varchar(1),
  nemz int,
  hnev1 varchar(30) NOT NULL,
  hnev2 varchar(28),
  hnev3 varchar(8),
  tnev varchar(63) NOT NULL,
  rovid varchar(35) NOT NULL,
  allapot int NOT NULL,
  tajaz varchar(4)
);
CREATE INDEX szervezet_szkod ON szervezet (szkod);
CREATE INDEX szervezet_rovid ON szervezet (rovid);

CREATE TABLE nevjegyz (
  internal_id SERIAL PRIMARY KEY NOT NULL,
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
  internal_id SERIAL PRIMARY KEY NOT NULL,
  valtip varchar(1) NOT NULL,
  maz varchar(2) NOT NULL,
  taz varchar(3) NOT NULL,
  sorsz varchar(3) NOT NULL,
  nemz int NOT NULL,
  a varchar(3) NOT NULL,
  f varchar(2) NOT NULL
);
CREATE INDEX sznapilf_sorsz ON sznapilf (sorsz);

CREATE TABLE tlista (
  internal_id SERIAL PRIMARY KEY NOT NULL,
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
  internal_id SERIAL PRIMARY KEY NOT NULL,
  maz varchar(2) NOT NULL,
  evk varchar(2) NOT NULL,
  szekh varchar(17) NOT NULL,
  szekhk varchar(2)
);

CREATE TABLE szavt (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  jfid int NOT NULL,
  jlid int NOT NULL,
  szav varchar(3) NOT NULL
);
CREATE INDEX szavt_jfid ON szavt (jfid);
CREATE INDEX szavt_jlid ON szavt (jlid);

CREATE TABLE szavf (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  jfid int NOT NULL,
  valtip varchar(1) NOT NULL,
  maz varchar(2) NOT NULL,
  taz varchar(3),
  sorsz varchar(3),
  a varchar(4) NOT NULL,
  b varchar(1) NOT NULL,
  bo varchar(5) NOT NULL,
  c varchar(1) NOT NULL,
  d varchar(1) NOT NULL,
  e varchar(4) NOT NULL,
  f varchar(4) NOT NULL,
  g varchar(4) NOT NULL,
  i1 varchar(4) NOT NULL,
  i2 varchar(1) NOT NULL,
  i3 varchar(1) NOT NULL,
  j varchar(4) NOT NULL,
  o varchar(3) NOT NULL,
  k1 varchar(4) NOT NULL,
  k2 varchar(1) NOT NULL,
  l varchar(3) NOT NULL,
  m varchar(3) NOT NULL,
  n varchar(4) NOT NULL,
  pa varchar(4) NOT NULL,
  pf varchar(4) NOT NULL,
  po varchar(3) NOT NULL,
  pk varchar(4) NOT NULL,
  pl varchar(3) NOT NULL,
  pm varchar(3) NOT NULL,
  pn varchar(4) NOT NULL,
  na varchar(3) NOT NULL,
  nf varchar(3) NOT NULL,
  no varchar(1) NOT NULL,
  nk varchar(3) NOT NULL,
  nl varchar(1) NOT NULL,
  nm varchar(2) NOT NULL,
  nn varchar(3) NOT NULL
);
CREATE INDEX szavf_jfid ON szavf (jfid);
CREATE INDEX szavf_sorsz ON szavf (sorsz);

CREATE TABLE jlcstag (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  jlcs varchar(3) NOT NULL,
  szkod varchar(4) NOT NULL,
  sorsz int NOT NULL
);
CREATE INDEX jlcstag_szkod ON jlcstag (szkod);
CREATE INDEX jlcstag_sorsz ON jlcstag (sorsz);

CREATE TABLE szeredmf (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  sfid int NOT NULL,
  oszint int NOT NULL,
  sfmaz varchar(2),
  sfevk varchar(2),
  valtip varchar(1) NOT NULL,
  forr varchar(1) NOT NULL,
  jogi varchar(1) NOT NULL,
  eredm varchar(1) NOT NULL,
  a varchar(7) NOT NULL,
  b varchar(1) NOT NULL,
  c varchar(1) NOT NULL,
  d varchar(6) NOT NULL,
  e int NOT NULL,
  f varchar(7) NOT NULL,
  ie varchar(1) NOT NULL,
  ilis varchar(6) NOT NULL,
  ilev varchar(6) NOT NULL,
  j int NOT NULL,
  ke varchar(5) NOT NULL,
  klis varchar(7) NOT NULL,
  m int NOT NULL,
  n int NOT NULL,
  jojkv varchar(5) NOT NULL,
  feldar varchar(5) NOT NULL,
  levell varchar(5) NOT NULL,
  levszl varchar(3) NOT NULL,
  eid int
);
CREATE INDEX szeredmf_sfid ON szeredmf (sfid);
CREATE INDEX szeredmf_eid ON szeredmf (eid);

CREATE TABLE terulet (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  maz varchar(2) NOT NULL,
  mnev varchar(22) NOT NULL,
  mrnev varchar(10) NOT NULL
);

CREATE TABLE kodok (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  kodcsop varchar(9) NOT NULL,
  kod varchar(2) NOT NULL,
  szoveg varchar(73) NOT NULL
);
CREATE INDEX kodok_kodcsop ON kodok (kodcsop);
CREATE INDEX kodok_kod ON kodok (kod);

CREATE TABLE szeredmt (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  sfid int NOT NULL,
  jlid int NOT NULL,
  szav varchar(7) NOT NULL,
  torsz varchar(7) NOT NULL,
  mandszav varchar(7) NOT NULL,
  hatar varchar(1) NOT NULL,
  mand varchar(2) NOT NULL
);
CREATE INDEX szeredmt_sfid ON szeredmt (sfid);
CREATE INDEX szeredmt_jlid ON szeredmt (jlid);

CREATE TABLE jlcssor (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  tip varchar(1) NOT NULL,
  id int NOT NULL,
  sorsz int NOT NULL,
  szkod int NOT NULL
);
CREATE INDEX jlcssor_id ON jlcssor (id);
CREATE INDEX jlcssor_sorsz ON jlcssor (sorsz);
CREATE INDEX jlcssor_szkod ON jlcssor (szkod);

CREATE TABLE telep (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  maz varchar(2) NOT NULL,
  taz varchar(3) NOT NULL,
  tnevi varchar(23) NOT NULL,
  tnev varchar(20) NOT NULL,
  tker varchar(2),
  ttip int NOT NULL
);

CREATE TABLE jlcs (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  jlcs varchar(3) NOT NULL,
  nevt varchar(28) NOT NULL,
  tag int NOT NULL
);

CREATE TABLE verzio (
  internal_id SERIAL PRIMARY KEY NOT NULL,
  ver varchar(19) NOT NULL,
  tjel int NOT NULL,
  eng1 int NOT NULL,
  eng2 int NOT NULL,
  feldar varchar(5) NOT NULL,
  levell varchar(5) NOT NULL,
  levszl int NOT NULL
);

CREATE TABLE szavkor (
  internal_id SERIAL PRIMARY KEY NOT NULL,
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
  internal_id SERIAL PRIMARY KEY NOT NULL,
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
  jlcs varchar(3) NOT NULL,
  sorsz int,
  erv varchar(1) NOT NULL,
  allapot int NOT NULL,
  fenykep int
);
CREATE INDEX ejelolt_eid ON ejelolt (eid);
CREATE INDEX ejelolt_sorsz ON ejelolt (sorsz);

CREATE TABLE tlistaj (
  internal_id SERIAL PRIMARY KEY NOT NULL,
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

