rm -rf json
mkdir json

wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/Valleir.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/Telepulesek.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/ListakEsJeloltek.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/Szervezetek.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04041400/szavossz/ReszvetelOrszag.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/EgyeniJeloltek.json
wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/Jlcs.json

jq -r '.list[] | .maz + " " + .maz + "-" + .taz' json/Telepulesek.json | xargs -n2 sh -c "wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04022333/ver/\$1/Szavazokorok-\$2.json" sh
jq -r '.list[] | .maz + " " + .maz + "-" + .taz' json/Telepulesek.json | xargs -n2 sh -c "wget --compression=gzip -P json https://vtr.valasztas.hu/ogy2022/data/04041400/szavossz/\$1/SzavkorJkv-\$2.json" sh
