1.upto(102) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  # merge adjacent blocks with equal text_density
  ::Boilerpipe::Filters::SimpleBlockFusionProcessor.process doc

  # merge text blocks next to each other
  ::Boilerpipe::Filters::BlockProximityFusion::MAX_DISTANCE_1.process doc

  # marks text blocks as content / non-content using boilerpipe alg
  ::Boilerpipe::Filters::DensityRulesClassifier.process doc

  content_count = doc.text_blocks.select(&:is_content?).size
  non_content_count = doc.text_blocks.select { |tb| !tb.is_content? }.size
  puts "id: #{id} content: #{content_count}  not_content: #{non_content_count}"
end
