require_relative './jars/boilerpipe-common-2.0-SNAPSHOT-jar-with-dependencies.jar'

java_import 'com.kohlschutter.boilerpipe.extractors.ArticleExtractor'
java_import 'com.kohlschutter.boilerpipe.sax.BoilerpipeHTMLParser'
java_import 'org.xml.sax.InputSource'
java_import java.io.StringReader

file_path = '../fixtures/parsing-big-xml-files-with-nokogiri.html'
file_contents = File.read(file_path)

# parse html and return text document
# return getText(new BoilerpipeSAXInput(new InputSource(new StringReader(html))).getTextDocument());

# monkey patch to check out private tag actions
class Java::ComKohlschutterBoilerpipeSax::BoilerpipeHTMLContentHandler
  attr_accessor :tagActions, :lastEvent, :textElementIdx
end

@parser = BoilerpipeHTMLParser.new
@string_reader = StringReader.new(file_contents)
@is = InputSource.new(@string_reader)
@parser.parse(@is);
@doc = @parser.to_text_document
@ch = @parser.content_handler
#puts @doc.debug_string

puts "number of text blocks: #{@doc.text_blocks.size}"

#@ruby_parser = HTMLParser.new
#@ruby_parser.parse(file_contents)
#@ruby_doc = @ruby_parser.text_document
#puts "number of text blocks: #{@ruby_doc.text_blocks.size}"
#
#
#


puts 'done'
