require 'boilerpipe'

# (1).upto(1024) do |id|
id = 21
file_contents = File.read("scraped/#{id}")
doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
# puts @doc.debug_s
puts doc.text_blocks.size
puts doc.debug_string
# end
