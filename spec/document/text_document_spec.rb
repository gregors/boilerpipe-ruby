require 'spec_helper'

module Boilerpipe
  describe Document::TextDocument do
    let(:text_blocks) { [Document::TextBlock.new('one'), Document::TextBlock.new('two')] }
    let(:doc) { Document::TextDocument.new('my title', text_blocks) }

    it 'Creates a new Text document with given TextBlocks and given title' do
      expect(doc).to be
    end

    it 'Returns the TextBlocks of this document' do
      expect(doc.text_blocks).to eq text_blocks
    end

    it 'Returns the main title for this document, or null if no such title has been set' do
      expect(doc.title).to eq 'my title'
    end

    it 'Updates the main title for this document' do
      doc.title = 'new title'
      expect(doc.title).to eq 'new title'
    end

    it 'Returns the content' do
      text_blocks.each { |tb| tb.content = true }
      content = doc.content
      expect(content).to eq "one\ntwo\n"
    end

    it 'Returns the content, non-content or both' do
      text_blocks.first.content = true
      content = doc.text(true, true)
      expect(content).to eq "one\ntwo\n"
    end

    it 'Returns detailed debugging information about the contained TextBlocks' do
      expect(doc.debug_s).to eq "[0-0;tl=0; nw=0;nwl=1;ld=0.0]\tBOILERPLATE,null\none\n[0-0;tl=0; nw=0;nwl=1;ld=0.0]\tBOILERPLATE,null\ntwo"
    end
  end
end
