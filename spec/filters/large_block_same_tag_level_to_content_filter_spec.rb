require 'spec_helper'

module Boilerpipe::Filters
  describe LargeBlockSameTagLevelToContentFilter do
    let(:text_block){ Boilerpipe::Document::TextBlock }

    let(:text_block1){ text_block.new('one', 3, 0, 0, 1, 0) }

    let(:main_content) do
       text_block.new('1'*200, 200, 0, 0, 1, 0)
       .tap{|t| t.content = true }
       .tap{|t| t.add_label(:VERY_LIKELY_CONTENT) }
    end

      let(:text_block3){ text_block.new('3'*150, 150, 0, 0, 1, 0) }
      let(:text_blocks){ [text_block1, main_content, text_block3] }
      let!(:doc){ Boilerpipe::Document::TextDocument.new('', text_blocks) }

      describe 'with large text blocks at the same level' do
        it 'marks as content' do
          expect(text_block1.is_content?).to be false
          expect(main_content.is_content?).to be true
          expect(text_block3.is_content?).to be false
          LargeBlockSameTagLevelToContentFilter.process(doc)
          expect(text_block1.is_content?).to be false
          expect(main_content.is_content?).to be true
          expect(text_block3.is_content?).to be true
        end

     end
  end
end
