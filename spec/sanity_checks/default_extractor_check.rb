require 'boilerpipe'

(1).upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  Boilerpipe::Extractors::DefaultExtractor.process doc

  content_count = doc.text_blocks.select(&:is_content?).size
  non_content_count = doc.text_blocks.select{|tb| !tb.is_content?}.size
  puts "id: #{id} content: #{content_count}  not_content: #{non_content_count}"
end
