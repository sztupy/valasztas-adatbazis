#!/usr/bin/env ruby
# Listás szavazatok kiszámolása választókörzetenként

require 'json'
require 'pp'

LISTAK = {}

JSON.parse(File.read("json/ListakEsJeloltek.json"))['list'].each do |data|
  LISTAK[data['tl_id']] = data['jlcs_nev'] unless data['nemzkod'];
end

MAPPING = {
  950 => "ÖSSZEFOGÁS",
  951 => "MKKP",
  942 => "MI HAZÁNK",
  952 => "FIDESZ"
}

SZKDATA = {}
ADATOK = {}
ELTERES = []


Dir.glob("json/**/Szavazokorok*.json").each do |filename|
  STDERR.print "."
  data = JSON.parse(File.read(filename))['data']
  maz = data['maz']
  taz = data['taz']
  SZKDATA[maz] ||= {}
  SZKDATA[maz][taz] ||= {}

  data['szavazokorok'].each do |szavzokor|
    sorsz = szavzokor['sorszam']
    evk = szavzokor['evk']

    SZKDATA[maz][taz][sorsz] = [evk, szavzokor['evk_nev'] +' '+szavzokor['szk_nev']]
  end
end

STDERR.puts

Dir.glob("json/**/SzavkorJkv*.json").each do |filename|
  STDERR.print "."
  JSON.parse(File.read(filename))['list'].each do |data|
    maz = data['maz']
    taz = data['taz']
    sorsz = data['sorsz']

    evk = SZKDATA.dig(maz,taz,sorsz)[0]

    p "MISSING SZAVDAT ", maz,taz,sorsz unless evk

    next unless evk

    egyeni = data['egyeni_jkv']
    lista = data['listas_jkv']

    ADATOK[maz] ||= {}
    ADATOK[maz][evk] ||= {}

    if lista['allapot'] == '3'
      current = ADATOK[maz][evk]
      osszesen = lista['partlistara']['megjelent']
      urna = lista['partlistara']['szl_belyegzett_urna'] # + lista['partlistara']['szl_belyegtlen_urna']

      if osszesen<urna
        current['elteres_lista'] ||= 0
        current['elteres_lista'] += urna-osszesen
        ELTERES << [urna-osszesen, "%s; %d: https://vtr.valasztas.hu/ogy2022/szavazohelyisegek/%s-%s-%s / %s " % ['L', urna-osszesen, maz, taz, sorsz,SZKDATA.dig(maz,taz,sorsz)[1]]]
      end
    end

    if egyeni['allapot'] == '3'
      current = ADATOK[maz][evk]
      osszesen = egyeni['szavazott_osszesen']
      urna = egyeni['szl_belyegzett_urna'] # + egyeni['szl_belyegtlen_urna']

      if osszesen<urna
        current['elteres_egyeni'] ||= 0
        current['elteres_egyeni'] += urna-osszesen
        ELTERES << [urna-osszesen, "%s; %d: https://vtr.valasztas.hu/ogy2022/szavazohelyisegek/%s-%s-%s / %s " % ['E', urna-osszesen, maz, taz, sorsz,SZKDATA.dig(maz,taz,sorsz)[1]]]
      end
    end

    SZKDATA[maz][taz][sorsz] = nil
  end
end

puts ADATOK.to_json
puts
ELTERES.sort_by{|e| -e[0]}.each do |e|
  puts e[1]
end
