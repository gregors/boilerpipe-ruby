require 'spec_helper'

module Boilerpipe::Filters
  describe SimpleBlockFusionProcessor do
    let(:text_blocks) { [text_block1, text_block2, text_block3, text_block4] }
    let!(:doc) { Boilerpipe::Document::TextDocument.new('', text_blocks) }

    context 'where blocks have same text density' do
      let(:text_block1) { Boilerpipe::Document::TextBlock.new('one',   0, 0, 0, 1, 0) }
      let(:text_block2) { Boilerpipe::Document::TextBlock.new('two',   0, 0, 0, 1, 1) }
      let(:text_block3) { Boilerpipe::Document::TextBlock.new('three', 0, 0, 0, 1, 2) }
      let(:text_block4) { Boilerpipe::Document::TextBlock.new('four',  0, 0, 0, 1, 3) }
      it 'the blocks are merged' do
        expect(doc.text_blocks.size).to eq 4
        SimpleBlockFusionProcessor.process(doc)
        expect(doc.text_blocks.size).to eq 1
      end
    end

    context 'where blocks have different text density' do
      let(:text_block1) { Boilerpipe::Document::TextBlock.new('one',   0, 0, 1, 1, 0) }
      let(:text_block2) { Boilerpipe::Document::TextBlock.new('two',   0, 0, 1, 2, 1) }
      let(:text_block3) { Boilerpipe::Document::TextBlock.new('three', 0, 0, 1, 3, 2) }
      let(:text_block4) { Boilerpipe::Document::TextBlock.new('four',  0, 0, 1, 4, 3) }

      it 'the blocks are not merged' do
        expect(doc.text_blocks.size).to eq 4
        SimpleBlockFusionProcessor.process(doc)
        expect(doc.text_blocks.size).to eq 4
      end
    end
  end
end
