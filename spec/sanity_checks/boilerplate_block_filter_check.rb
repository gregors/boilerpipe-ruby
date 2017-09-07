require 'boilerpipe'

#id = 2
(1).upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  pre_count = doc.text_blocks.size
  Boilerpipe::Filters::BoilerplateBlockFilter::INSTANCE_KEEP_TITLE.process(doc)

  post_count = doc.text_blocks.size

  #puts doc.debug_string
  puts "diff: #{pre_count - post_count}"

end
