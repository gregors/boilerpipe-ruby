module Boilerpipe::SAX
  class BoilerpipeHTMLParser
    def self.parse(text)
      # strip out tags that cause issues
      text = Preprocessor.strip(text)

      # use nokogiri to fix any bad tags, errors - keep experimenting with this
      text = Nokogiri::HTML(text).to_html
      handler = HTMLContentHandler.new
      noko_parser = Nokogiri::HTML::SAX::Parser.new(handler)
      noko_parser.parse(text)
      handler.text_document
    end
  end
end
