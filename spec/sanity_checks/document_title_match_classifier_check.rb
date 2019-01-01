require 'boilerpipe'

id = 1024
# (1).upto(1024) do |id|
file_contents = File.read("scraped/#{id}")
doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
Boilerpipe::Filters::DocumentTitleMatchClassifier
  .new(doc.title)
  .process(doc)

# puts doc.debug_string
tbs = doc.text_blocks
#  puts tbs.size
tb = tbs.find { |tb| tb.has_label?(:TITLE) }
if tb
  puts "has title id: #{id}"
end
puts doc.debug_string
# end
