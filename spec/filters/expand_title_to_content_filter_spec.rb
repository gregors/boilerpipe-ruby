require 'spec_helper'

module Boilerpipe::Filters
  describe ExpandTitleToContentFilter do
    describe '#process' do
      let(:text_block) { Boilerpipe::Document::TextBlock }
      let(:text_block1){ text_block.new('one', 3, 0, 0, 0, 0) }
      let(:text_block2){ text_block.new('two', 3, 1, 1, 0, 1) }
      let(:text_block3){ text_block.new('three', 5, 2, 1, 0, 2) }
      let(:text_blocks){ [text_block1, text_block2, text_block3] }

      before do
        text_block1.add_label(:TITLE)
        text_block1.content = false

        text_block2.add_label(:MIGHT_BE_CONTENT)
        text_block2.content = false

        text_block3.content = true
      end

      context 'if a Title textblock has a subsequent Content textblock' do
        let!(:doc){ Boilerpipe::Document::TextDocument.new('', text_blocks) }


        it 'marks all textblocks in between title and know content as content if they might be content' do
          expect(text_block1.content).to be false
          expect(text_block2.content).to be false
          expect(text_block3.content).to be true
          ExpandTitleToContentFilter.process(doc)
          expect(text_block1.content).to be false
          expect(text_block2.content).to be true
          expect(text_block3.content).to be true
        end
      end

      context 'if a Title textblock doesnt have a subsequent Content textblock' do
        let!(:doc){ Boilerpipe::Document::TextDocument.new('', [text_block1]) }

        it 'doesnt mark textblocks as content' do
          expect(text_block1.content).to be false
          expect(text_block2.content).to be false
          ExpandTitleToContentFilter.process(doc)
          expect(text_block1.content).to be false
          expect(text_block2.content).to be false
        end
      end

    end
  end
end
