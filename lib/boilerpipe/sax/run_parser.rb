require 'nokogiri'
require_relative './parser'


file = File.open('../../../spec/fixtures/parsing-big-xml-files-with-nokogiri.html')
puts file

noko = Nokogiri::HTML::SAX::Parser.new(Parser.new)
puts noko

#works
puts noko.parse(file.read)

#does not work
# puts noko.parse(file

