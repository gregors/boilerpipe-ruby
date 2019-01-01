require 'boilerpipe'

# id = 1024
1.upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
  Boilerpipe::Filters::TerminatingBlocksFinder.process(doc)
  tb = doc.text_blocks.select { |tb| tb.has_label?(:INDICATES_END_OF_TEXT) }
  puts "end of text size: #{tb.size} has title id: #{id}" if tb.size > 0
  # puts doc.debug_string
end
