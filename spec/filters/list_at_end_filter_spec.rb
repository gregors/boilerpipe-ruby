require 'spec_helper'

module Boilerpipe::Filters
  describe ListAtEndFilter do
    describe '#process' do
      context 'when a text block is the last LI tag in a list' do
        let(:text_block1){ Boilerpipe::Document::TextBlock.new('one') }
        let(:text_block2){ Boilerpipe::Document::TextBlock.new('two') }
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
            ListAtEndFilter.new.process(doc)
            expect(text_block2.content).to be true
          end

          it 'returns changes to true' do
            expect(ListAtEndFilter.new.process(doc)).to be true
          end
        end
      end

      context 'when a text block doesnt change' do
        let(:empty_doc){ Boilerpipe::Document::TextDocument.new('', []) }
        it 'returns changes to false' do
            expect(ListAtEndFilter.new.process(empty_doc)).to be false
        end
      end
    end
  end
end
