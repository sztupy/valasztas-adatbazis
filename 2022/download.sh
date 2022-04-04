rm -rf json
mkdir json
mkdir json/01
mkdir json/02
mkdir json/03
mkdir json/04
mkdir json/05
mkdir json/06
mkdir json/07
mkdir json/08
mkdir json/09
mkdir json/10
mkdir json/11
mkdir json/12
mkdir json/13
mkdir json/14
mkdir json/15
mkdir json/16
mkdir json/17
mkdir json/18
mkdir json/19
mkdir json/20

wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/Valleir.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/Telepulesek.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/ListakEsJeloltek.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/Szervezetek.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04041400/szavossz/ReszvetelOrszag.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/EgyeniJeloltek.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/Jlcs.json

jq -r '.list[] | .maz + " " + .maz + "-" + .taz' json/Telepulesek.json | xargs -n2 sh -c "wget --compression=gzip -P json/\$1 https://vtr.valasztas.hu/ogy2022/data/04022333/ver/\$1/Szavazokorok-\$2.json" sh
jq -r '.list[] | .maz + " " + .maz + "-" + .taz' json/Telepulesek.json | xargs -n2 sh -c "wget --compression=gzip -P json/\$1 https://vtr.valasztas.hu/ogy2022/data/04041400/szavossz/\$1/SzavkorJkv-\$2.json" sh
