require 'boilerpipe'

file_path = './spec/fixtures/parsing-big-xml-files-with-nokogiri.html'
file_contents = File.read(file_path)

#puts 'ruby version'

@ruby_doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
@tbf = Boilerpipe::Filters::TerminatingBlocksFinder
puts "terminating blocks finder: #{@tbf.process(@ruby_doc)}"
puts "number of text blocks: #{@ruby_doc.text_blocks.size}"

end_of_text_count = 0
@ruby_doc.text_blocks.each do |tb|
  end_of_text_count += 1 if tb.has_label? :INDICATES_END_OF_TEXT
end
puts "end of text count: #{end_of_text_count}"

puts 'done'
