require 'spec_helper'

module Boilerpipe
  describe Extractors::ArticleExtractor do
    describe '.process'
    describe '.get_text(html)'
    describe '.get_text(input source)'
    # ArticleExtractor -> input htlm string or io -> runs through html sax parser -> gets back document with text blocks 
    #  -> runs document through list of filters -> each filter sets content flag true or false on each text block
    #  -> finally document is returned and document.content returns all text blocks with content flag set
  end
end
