require 'boilerpipe'

# id = 1024
# files = (1.2024).to_a
files = [2]

files.each do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
  Boilerpipe::Filters::NumWordsRulesClassifier.process(doc)

  # puts doc.debug_string
  tbs = doc.text_blocks
  #  puts tbs.size
  tb = tbs.select { |tb| tb.is_content? }
  total = tbs.size
  if tb.size > 0
    puts "text block with content: #{tb.size} out of #{total} has file id: #{id}"
  end
end
