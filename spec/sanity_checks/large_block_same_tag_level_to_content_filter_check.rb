require 'boilerpipe'

#id = 2
(1).upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  Boilerpipe::Filters::NumWordsRulesClassifier.process doc
  Boilerpipe::Filters::KeepLargestBlockFilter::INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS.process doc


  pre_count = doc.text_blocks.select(&:is_content?).size
  Boilerpipe::Filters::LargeBlockSameTagLevelToContentFilter.process doc
  post_count = doc.text_blocks.select(&:is_content?).size

  #puts doc.debug_string
  puts "id: #{id} pre: #{pre_count}  post: #{post_count}"
end
