require 'boilerpipe'

#id = 1024
(1).upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
  Boilerpipe::Filters::NumWordsRulesClassifier.process(doc)

  #puts doc.debug_string
  tbs =  doc.text_blocks
#  puts tbs.size
  tb = tbs.select{|tb| tb.is_content? }
  if tb.size > 0
    puts "size: #{tb.size} has title id: #{id}"
  end
end
