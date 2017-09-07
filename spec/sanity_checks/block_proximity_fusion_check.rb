require 'boilerpipe'

#id = 2
(1).upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  pre_count = doc.text_blocks.size

  # marks text blocks as content / non-content using boilerpipe alg
  Boilerpipe::Filters::NumWordsRulesClassifier.process doc


  # merge text blocks next to each other
  Boilerpipe::Filters::BlockProximityFusion::MAX_DISTANCE_1.process(doc)
  post_count = doc.text_blocks.size

  #puts doc.debug_string
  puts "id: #{id} #{pre_count}  #{post_count}"

end
