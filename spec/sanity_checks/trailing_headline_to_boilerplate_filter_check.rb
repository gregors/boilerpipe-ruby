require 'boilerpipe'

1.upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  pre_count = doc.text_blocks.select { |tb| tb.is_content? == false }.count
  Boilerpipe::Filters::TrailingHeadlineToBoilerplateFilter.process(doc)
  post_count = doc.text_blocks.select { |tb| tb.is_content? == false }.count

  # puts doc.debug_string
  puts "diff: #{post_count - pre_count}"
end
