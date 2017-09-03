require 'boilerpipe'

file_path = '../fixtures/parsing-big-xml-files-with-nokogiri.html'
file_contents = File.read(file_path)

#puts 'ruby version'

@doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
#puts @doc.debug_s

puts @doc.text_blocks.size
