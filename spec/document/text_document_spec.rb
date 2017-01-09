require 'spec_helper'

module Boilerpipe
  describe Document::TextDocument do
    it 'Creates a new Text document with given TextBlocks, and no title'
    it 'Creates a new Text document with given TextBlocks and given title'
    it 'Returns the TextBlocks of this document'
    it 'Returns the main title for this document, or null if no such title has ben set'
    it 'Updates the main title for this document'
    it 'Returns the content'
    it 'Returns the content, non-content or both'
    it 'Returns detailed debugging information about the contained TextBlocks'
  end
end
