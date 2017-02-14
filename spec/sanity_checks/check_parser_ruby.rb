require 'boilerpipe'

file_path = '../fixtures/parsing-big-xml-files-with-nokogiri.html'
file_contents = File.read(file_path)

puts 'ruby version'

@ruby_doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
puts @ruby_doc.debug_s

puts "number of text blocks: #{@ruby_doc.text_blocks.size}"
puts 'done'
