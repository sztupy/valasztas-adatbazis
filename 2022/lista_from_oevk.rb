#!/usr/bin/env ruby
# Listás szavazatok kiszámolása választókörzetenként

require 'json'
require 'pp'

LISTAK = {}

JSON.parse(File.read("json/ListakEsJeloltek.json"))['list'].each do |data|
  LISTAK[data['tl_id']] = data['jlcs_nev'] unless data['nemzkod'];
end

SZKDATA = {}
ADATOK = {}

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
    SZKDATA[maz][taz][sorsz] = evk
  end
end

STDERR.puts

total = 0
megjelent = 0

Dir.glob("json/**/SzavkorJkv*.json").each do |filename|
  STDERR.print "."
  JSON.parse(File.read(filename))['list'].each do |data|
    maz = data['maz']
    taz = data['taz']
    sorsz = data['sorsz']

    evk = SZKDATA.dig(maz,taz,sorsz)

    p "MISSING SZAVDAT ", maz,taz,sorsz unless evk
    next unless evk

    SZKDATA[maz][taz][sorsz] = nil

    ADATOK[maz] ||= {}
    ADATOK[maz][evk] ||= {}

    current = ADATOK[maz][evk]

    current['total'] ||= 0
    current['megjelent'] ||= 0
    LISTAK.each_pair do |k,_|
      current[k] ||= 0
    end

    lista = data['listas_jkv']

    next if lista['allapot'] != '3'

    current['total'] += lista['partlistara']['vp_osszes']
    current['megjelent'] += lista['partlistara']['megjelent']

    lista['tetelek'].each do |tetel|
      next unless LISTAK[tetel['tl_id']]

      current[tetel['tl_id']] += tetel['szavazat']
    end

    total += lista['partlistara']['vp_osszes']
    megjelent += lista['partlistara']['megjelent']
  end
end

SZKDATA.each_pair do |maz, _|
  SZKDATA[maz].each_pair do |taz, _|
    SZKDATA[maz][taz].each_pair do |sorsz, _|
      p "MISSING RESULT ", maz,taz,sorsz if SZKDATA[maz][taz][sorsz]
    end
  end
end

puts ADATOK.to_json
