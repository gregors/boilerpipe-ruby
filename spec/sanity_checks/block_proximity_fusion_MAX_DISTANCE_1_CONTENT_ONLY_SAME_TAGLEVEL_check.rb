require 'boilerpipe'

# id = 2
1.upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  pre_count = doc.text_blocks.size
  Boilerpipe::Filters::NumWordsRulesClassifier.process doc
  Boilerpipe::Filters::BlockProximityFusion::MAX_DISTANCE_1_CONTENT_ONLY_SAME_TAGLEVEL.process doc

  post_count = doc.text_blocks.size

  # puts doc.debug_string
  puts "id: #{id} #{pre_count}  #{post_count}"
end
