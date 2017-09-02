require 'boilerpipe'

(1).upto(1024) do |id|
  c = File.read("scraped/#{id}")
  out = Boilerpipe::UnicodeTokenizer.tokenize(c)
  puts out.count
end
