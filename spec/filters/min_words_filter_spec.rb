require 'spec_helper'

module Boilerpipe::Filters
  describe MinWordsFilter do
    describe '#process' do
      let(:text_block) { Boilerpipe::Document::TextBlock }
      let(:text_block1) { text_block.new('one two three', 3) }
      let(:text_block2) { text_block.new('one two', 2) }
      let(:text_blocks) { [text_block1, text_block2] }

      let!(:doc) { Boilerpipe::Document::TextDocument.new('', text_blocks) }

      before do
        text_block1.content = true
        text_block2.content = true
      end

      it 'keeps blocks with at least k words' do
        expect(text_block1.content).to be true
        expect(text_block2.content).to be true
        MinWordsFilter.process 3, doc
        expect(text_block1.content).to be true
        expect(text_block2.content).to be false
      end
    end
  end
end
