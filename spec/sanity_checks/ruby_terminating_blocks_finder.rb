require 'boilerpipe'

file_path = '../fixtures/parsing-big-xml-files-with-nokogiri.html'
file_contents = File.read(file_path)

#puts 'ruby version'

@ruby_doc = Boilerpipe::SAX::BoilerpipeHTMLParser.parse(file_contents)
@tbf = Boilerpipe::Filters::TerminatingBlocksFinder
puts "terminating blocks finder: #{@tbf.process(@ruby_doc)}"
puts 'done'
