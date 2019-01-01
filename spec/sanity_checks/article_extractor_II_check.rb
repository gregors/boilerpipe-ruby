require 'boilerpipe'

# id = 2
# (1).upto(1024) do |id|
1.upto(102) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  #  Boilerpipe::Extractors::ArticleExtractor.process doc
  title = doc.title

  filters = ::Boilerpipe::Filters

  # marks text blocks as end of text with :INDICATES_END_OF_TEXT
  filters::TerminatingBlocksFinder.process doc

  # marks text blocks as title
  filters::DocumentTitleMatchClassifier.new(title).process doc

  # marks text blocks as content / non-content using boilerpipe alg
  filters::NumWordsRulesClassifier.process doc

  # marks text blocks after INDICATES_END_OF_TEXT non-content
  filters::IgnoreBlocksAfterContentFilter.process doc

  # marks HEADING text blocks as non-content after existing content
  filters::TrailingHeadlineToBoilerplateFilter.process doc

  # merge text blocks next to each other
  filters::BlockProximityFusion::MAX_DISTANCE_1.process doc

  # removes non-content text blocks
  filters::BoilerplateBlockFilter::INSTANCE_KEEP_TITLE.process doc

  # merge text blocks next to each other if they are the same tag level
  # not great
  filters::BlockProximityFusion::MAX_DISTANCE_1_CONTENT_ONLY_SAME_TAGLEVEL.process doc

  # Keeps only the largest text block as content
  filters::KeepLargestBlockFilter::INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS.process doc

  # Marks all TextBlocks "content" which are between the headline and the part is already content
  filters::ExpandTitleToContentFilter.process doc

  # mark text blocks with a lot of text at the same tag level as the largest current content as additional content
  filters::LargeBlockSameTagLevelToContentFilter.process doc

  # Marks nested list-item blocks after the end of the main content as content.
  filters::ListAtEndFilter.process doc

  content_count = doc.text_blocks.select(&:is_content?).size
  non_content_count = doc.text_blocks.select { |tb| !tb.is_content? }.size
  puts "id: #{id} content: #{content_count}  not_content: #{non_content_count}"

  # puts doc.debug_string
end
