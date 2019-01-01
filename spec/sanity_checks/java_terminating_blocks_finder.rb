require_relative './jars/boilerpipe-common-2.0-SNAPSHOT-jar-with-dependencies.jar'

java_import 'com.kohlschutter.boilerpipe.extractors.ArticleExtractor'
java_import 'com.kohlschutter.boilerpipe.sax.BoilerpipeHTMLParser'
java_import 'com.kohlschutter.boilerpipe.filters.english.TerminatingBlocksFinder'
java_import 'com.kohlschutter.boilerpipe.document.TextBlock'
java_import 'org.xml.sax.InputSource'
java_import java.io.StringReader

file_path = './spec/fixtures/parsing-big-xml-files-with-nokogiri.html'
file_contents = File.read(file_path)

# parse html and return text document
# puts 'java version'
@parser = BoilerpipeHTMLParser.new
@string_reader = StringReader.new(file_contents)
@is = InputSource.new(@string_reader)
@parser.parse(@is);
@doc = @parser.to_text_document
@tbf = TerminatingBlocksFinder.new
# text_block = TextBlock.new("reader views reader")
# @doc.text_blocks.last.merge_next(text_block)
puts "terminating blocks finder: #{@tbf.process(@doc)}"
puts "number of text blocks: #{@doc.text_blocks.size}"
end_of_text_count = 0
@doc.text_blocks.each do |tb|
  end_of_text_count += 1 if tb.has_label? 'de.l3s.boilerpipe/INDICATES_END_OF_TEXT'
end
puts "end of text count: #{end_of_text_count}"

puts 'done'
