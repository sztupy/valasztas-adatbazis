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

current = nil


CSV.foreach("2018_lista.csv", headers: true) do |row|
  if row['MEGYEKÓD']
    maz = row['MEGYEKÓD']
    evk = row['OEVK']

    ADATOK[maz] ||= {}
    ADATOK[maz][evk] ||= {
      'total' => 0,
      'megjelent' => 0,
      'ervenyes' => 0
    }
    current = ADATOK[maz][evk]

    current['total'] += row['VÁLASZTÓPOLGÁR'].to_i
    current['megjelent'] += row['MEGJELENTEK'].to_i
    current['ervenyes'] += row['ÉRVÉNYES'].to_i
  elsif row['LISTA']
    map = MAPPING[row['LISTA']]
    map ||= "EGYÉB"

    current[map] ||= 0
    current[map] += row['SZAVAZAT'].to_i
  end
end

puts ADATOK.to_json
