require_relative './jars/boilerpipe-common-2.0-SNAPSHOT-jar-with-dependencies.jar'
java_import 'com.kohlschutter.boilerpipe.extractors.ArticleExtractor'
java_import 'com.kohlschutter.boilerpipe.sax.BoilerpipeHTMLParser'
java_import 'com.kohlschutter.boilerpipe.filters.heuristics.DocumentTitleMatchClassifier'
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
puts "title: #{@doc.title}"
title = @rdoc.title
@filter = DocumentTitleMatchClassifier.new(title)
puts "Document title match classifier: #{@filter.process(@doc)}"
puts "number of text blocks: #{@doc.text_blocks.size}"
puts 'done'
