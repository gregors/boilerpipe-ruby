require 'boilerpipe'

# id = 2
1.upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  # marks text blocks as content / non-content using boilerpipe alg
  Boilerpipe::Filters::NumWordsRulesClassifier.process doc
  pre_count = doc.text_blocks.select(&:is_content?).size

  # Keeps only the largest text block as content
  Boilerpipe::Filters::KeepLargestBlockFilter::INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS.process doc

  post_count = doc.text_blocks.select(&:is_content?).size

  # puts doc.debug_string
  puts "id: #{id} pre: #{pre_count}  post: #{post_count}"
end
