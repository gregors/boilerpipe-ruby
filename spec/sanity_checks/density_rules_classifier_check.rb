require 'boilerpipe'

(1).upto(1024) do |id|
  file_contents = File.read("scraped/#{id}")
  doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)

  pre_count = doc.text_blocks.size
  Boilerpipe::Filters::DensityRulesClassifier.process doc

  post_count = doc.text_blocks.size
  puts "id: #{id} #{pre_count}  #{post_count}"
end
