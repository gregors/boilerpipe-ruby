require 'spec_helper'

module Boilerpipe::Filters
  describe KeepLargestBlockFilter do
      let(:text_block){ Boilerpipe::Document::TextBlock }
      let(:text_block1){ text_block.new('one', 3, 0, 0, 1, 0) }
      let(:text_block2){ text_block.new('largest', 7, 0, 0, 1, 0).tap{|t| t.content = true } }
      let(:text_block3){ text_block.new('3'*150, 150, 0, 0, 1, 0) }

      let(:text_blocks){ [text_block1, text_block2, text_block3] }
      let!(:doc){ Boilerpipe::Document::TextDocument.new('', text_blocks) }

      describe '.INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS' do
        describe '#process' do

          context 'with a non-content block more than 150 chars' do
            let(:text_block3){ text_block.new('3'*150, 150, 0, 0, 1, 0) }

            it 'expands same tag level with text more than 150' do
              expect(text_block3.is_content?).to be false
              KeepLargestBlockFilter::INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS.process(doc)
              expect(text_block3.is_content?).to be true
            end
          end

          context 'with a non-content block less than 150 chars' do
            let(:text_block3){ text_block.new('3', 3, 0, 0, 1, 0) }

            it 'expands same tag level with text more than 150' do
              expect(text_block3.is_content?).to be false
              KeepLargestBlockFilter::INSTANCE_EXPAND_TO_SAME_TAGLEVEL_MIN_WORDS.process(doc)
              expect(text_block3.is_content?).to be false
            end
          end

        end
      end
  end
end
