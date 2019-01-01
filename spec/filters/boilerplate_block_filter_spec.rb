require 'spec_helper'

module Boilerpipe::Filters
  describe BoilerplateBlockFilter do
    let(:text_block2) { Boilerpipe::Document::TextBlock.new('two') }
    let(:text_block3) { Boilerpipe::Document::TextBlock.new('three') }
    let(:text_blocks) { [text_block1, text_block2, text_block3] }
    let!(:doc) { Boilerpipe::Document::TextDocument.new('', text_blocks) }

    describe '#process' do
      context 'with INSTANCE_KEEP_TITLE' do
        let(:text_block1) { Boilerpipe::Document::TextBlock.new('one').tap { |t| t.add_label(:TITLE) } }
        it 'keeps the text block for :TITLE labels' do
          expect(doc.text_blocks.size).to eq 3
          filter = BoilerplateBlockFilter::INSTANCE_KEEP_TITLE
          filter.process(doc)
          expect(doc.text_blocks.size).to eq 1
        end
      end

      context 'with no label to keep' do
        let(:text_block1) { Boilerpipe::Document::TextBlock.new('one') }
        it 'removes the text block' do
          expect(doc.text_blocks.size).to eq 3
          filter = BoilerplateBlockFilter::INSTANCE_KEEP_TITLE
          filter.process(doc)
          expect(doc.text_blocks.size).to eq 0
        end
      end
    end
  end
end
