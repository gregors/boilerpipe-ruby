require 'boilerpipe'

#id = 1024
#id = 2
(1).upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
  Boilerpipe::Filters::TerminatingBlocksFinder.process(doc)

#  tb = doc.text_blocks.select{|tb| tb.has_label?(:INDICATES_END_OF_TEXT) }
   pre_count = doc.text_blocks.select{|tb| tb.is_content? == false }.count
#  puts "end of text size: #{tb.size} has title id: #{id}" if tb.size > 0
  #puts doc.debug_string

  Boilerpipe::Filters::IgnoreBlocksAfterContentFilter.process(doc)
  post_count = doc.text_blocks.select{|tb| tb.is_content? == false }.count

  #puts doc.debug_string
  puts "diff: #{post_count}"
end
