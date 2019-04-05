require 'spec_helper'

module Boilerpipe::Filters
  describe MinClauseWordsFilter do
    describe '#process' do
      let(:text_block) { Boilerpipe::Document::TextBlock }
      let(:text_block1) { text_block.new('one two three four five, one two', 7) }
      let(:text_block2) { text_block.new('one two', 2) }
      let(:text_blocks) { [text_block1, text_block2] }

      let!(:doc) { Boilerpipe::Document::TextDocument.new('', text_blocks) }

      before do
        text_block1.content = true
        text_block2.content = true
      end

      it 'keeps blocks with one clause of at least 5 words' do
        expect(text_block1.content).to be true
        expect(text_block2.content).to be true
        MinClauseWordsFilter.process doc
        expect(text_block1.content).to be true
        expect(text_block2.content).to be false
      end
    end
  end
end
