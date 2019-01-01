require 'boilerpipe'

file_path = './spec/fixtures/parsing-big-xml-files-with-nokogiri.html'
file_contents = File.read(file_path)

# puts 'ruby version'

@ruby_doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
puts "title: #{@ruby_doc.title}"
title = @ruby_doc.title
@filter = Boilerpipe::Filters::DocumentTitleMatchClassifier.new(title)
puts "Document title match classifier: #{@filter.process(@ruby_doc)}"
puts "number of text blocks: #{@ruby_doc.text_blocks.size}"
puts 'done'
