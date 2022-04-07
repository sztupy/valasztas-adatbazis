#!/usr/bin/env ruby

require 'csv'
require 'json'

ADATOK = {}

MAPPING = {
  "FIDESZ - MAGYAR POLGÁRI SZÖVETSÉG-KERESZTÉNYDEMOKRATA NÉPPÁRT" => "FIDESZ",
  "LEHET MÁS A POLITIKA" => "LMP",
  "MAGYAR SZOCIALISTA PÁRT-PÁRBESZÉD MAGYARORSZÁGÉRT PÁRT" => "MSZP",
  "MOMENTUM MOZGALOM" => "MOMENTUM",
  "JOBBIK MAGYARORSZÁGÉRT MOZGALOM" => "JOBBIK",
  "DEMOKRATIKUS KOALÍCIÓ" => "DK",
  "MAGYAR KÉTFARKÚ KUTYA PÁRT" => "MKKP",
  "EGYÜTT - A KORSZAKVÁLTÓK PÁRTJA" => "EGYÜTT"
}

ELTERES = []

current = nil


CSV.foreach("2018_lista.csv", headers: true) do |row|
  if row['MEGYEKÓD']
    maz = row['MEGYEKÓD']
    evk = row['OEVK']

    megjelentek = row['MEGJELENTEK'].to_i
    urna = row['URNÁBAN_LEVŐ'].to_i

    elteres = urna-megjelentek

    if elteres > 0
      ADATOK[maz] ||= {}
      ADATOK[maz][evk] ||= {
        'elteres' => 0
      }

      current = ADATOK[maz][evk]

      current['elteres'] += elteres
      ELTERES << [maz,row['TELEPÜLÉS_SORSZÁM'],row['SZAVAZÓKÖR'], elteres]
    end
  end
end

puts ADATOK.to_json
puts
puts ELTERES.to_json
