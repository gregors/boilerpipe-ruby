require 'spec_helper'

module Boilerpipe::Filters
  describe MarkEverythingContentFilter do
    let(:text_block1){ Boilerpipe::Document::TextBlock.new('one',   0, 0, 0, 0, 0) }
    let(:text_block2){ Boilerpipe::Document::TextBlock.new('two',   0, 0, 0, 0, 1) }
    let(:text_block3){ Boilerpipe::Document::TextBlock.new('three', 0, 0, 0, 0, 2) }
    let(:text_block4){ Boilerpipe::Document::TextBlock.new('four',  0, 0, 0, 0, 3) }

    let(:text_blocks){ [text_block1, text_block2, text_block3, text_block4] }
    let!(:doc){ Boilerpipe::Document::TextDocument.new('', text_blocks) }
    before do
      text_block1.content = true
      text_block2.content = false
      text_block3.content = false
      text_block4.content = true
    end

    describe '#process' do
      it 'marks everything as content' do
        expect(doc.text_blocks.select(&:is_content?).size).to be 2
        MarkEverythingContentFilter.process(doc)
        expect(doc.text_blocks.select(&:is_content?).size).to be 4
      end
    end

  end
end
