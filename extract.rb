#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'csv'

Bundler.require

DB_TYPE = :sqlite

delegaltak = CSV.read("data/partdelegaltak.csv", headers: true)

headers = delegaltak.headers.map do |h|
  {
    orig: h,
    safe: h.downcase.gsub(/[^a-z]/,'')
  }
end

File.open("data/partdelegaltak.xml","w+") do |out|
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.partdelegalt {
      delegaltak.each do |row|
        xml.partdelegaltr {
          headers.each do |col|
            xml.send(col[:safe], row[col[:orig]])
            if col[:safe] == 'jellcsoport'
              str = row[col[:orig]] || ''
              xml.send('jellcsopid', str.split(" - ").first)
            end
          end
        }
      end
    }
  end
  out.print builder.to_xml
end

File.open("schema.sql", "w+") do |schema_file|

Dir.glob('data/*.xml').each do |filename|
  xml = File.open(filename) { |f| Nokogiri::XML(f) }
  root = xml.elements.first
  table_name = root.name

  schema = {}

  root.elements.each do |row|
    row.elements.each do |col|
      schema[col.name] ||= {
        type: :integer,
        null: false,
        size: 0,
        index: col.name.match?('id') || col.name.match?('kod') || col.name.match?('sorsz')
      }
      if col.text.empty?
        schema[col.name][:null] = true
      else
        schema[col.name][:size] = [schema[col.name][:size], col.text.length].max
        unless col.text.match?(/\A-?[1-9][0-9]*\Z/) || col.text == '0'
          schema[col.name][:type] = :string
        end
      end
    end
  end

  schema_file.puts "CREATE TABLE #{table_name} ("
  schema_file.print "  internal_id #{DB_TYPE == :postgres ? 'SERIAL' : 'INTEGER'} PRIMARY KEY NOT NULL"
  schema.each_pair do |k,v|
    schema_file.puts ","
    schema_file.print "  #{k} "
    schema_file.print case v[:type]
    when :integer then 'int'
    when :string then "varchar(#{v[:size]})"
    end
    schema_file.print " NOT NULL" unless v[:null]
  end
  schema_file.puts
  schema_file.puts ");"
  schema.each_pair do |k,v|
    if v[:index]
      schema_file.puts "CREATE INDEX #{table_name}_#{k} ON #{table_name} (#{k});"
    end
  end
  schema_file.puts

  File.open("sql/#{table_name}.sql","w+") do |out|
    keys_order = schema.keys
    out.print "INSERT INTO #{table_name} ("
    out.print keys_order.join(",")
    out.puts ") VALUES"
    first = true
    root.elements.each do |row|
      out.puts "," unless first
      first = false
      values = {}
      row.elements.each do |col|
        if col.text.empty?
          values[col.name] = 'NULL'
        elsif schema[col.name][:type] == :integer
          values[col.name] = col.text
        else
          values[col.name] = "'#{col.text.gsub(/['\\]/, '')}'"
        end
      end
      out.print "(#{keys_order.map { |k| values[k] }.join(",")})"
    end
    out.puts ";"
  end


  File.open("csv/#{table_name}.csv","w+") do |out|
    keys_order = schema.keys
    out.print keys_order.join(";")
    out.puts
    root.elements.each do |row|
      values = {}
      row.elements.each do |col|
        if col.text.empty?
          values[col.name] = ''
        elsif schema[col.name][:type] == :integer
          values[col.name] = col.text
        else
          values[col.name] = "'#{col.text.gsub(/['\\]/, '')}'"
        end
      end
      out.print keys_order.map { |k| values[k] }.join(";")
      out.puts
    end
  end

end

end
