require 'spec_helper'

module Boilerpipe::Filters
  describe ListAtEndFilter do
    describe '#process' do
      context 'when a text block is the last LI tag in a list' do
        let(:text_block){ Boilerpipe::Document::TextBlock }
        let(:text_block1){ text_block.new('one') }
        let(:text_block2){ text_block.new('two') }
        let(:text_blocks){ [text_block1, text_block2] }

        let!(:doc){ Boilerpipe::Document::TextDocument.new('', text_blocks) }

        context 'it might be content and has a higher tag level then its predecessors and has no link density' do
          before do
            text_block1.add_label(:LI)
            text_block1.add_label(:VERY_LIKELY_CONTENT)
            text_block1.content = true

            text_block2.add_label(:LI)
            text_block2.add_label(:MIGHT_BE_CONTENT)
            text_block2.set_tag_level(1)
          end

          it 'sets text block to content' do
            expect(text_block2.content).to be false
            ListAtEndFilter.process doc
            expect(text_block2.content).to be true
          end
        end
      end

    end
  end
end
