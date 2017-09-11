require 'spec_helper'

module Boilerpipe::Filters
  describe BlockProximityFusion do
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
      context 'where blocks exceed distance' do
        it 'doesnt change blocks' do
         expect(doc.text_blocks.size).to eq 4
         filter = BlockProximityFusion.new(1, true, false)
         filter.process(doc)
         expect(doc.text_blocks.size).to eq 4
        end
      end

      context 'where blocks do not exceed distance' do
        it 'Fuses adjacent blocks' do
          expect(doc.text_blocks.last.text.size ).to eq 4
          filter = BlockProximityFusion.new(1, false, false)
          filter.process(doc)
          expect(doc.text_blocks.last.text ).to eq "three\nfour"
        end

        it 'Removes one of the blocks from the Text Document' do
          expect(doc.text_blocks.size).to eq 4
          filter = BlockProximityFusion.new(1, false, false)
          filter.process(doc)
          expect(doc.text_blocks.size).to eq 3
        end
      end

      context 'when the Text Document only has one text block' do
        let(:doc){ Boilerpipe::Document::TextDocument.new('', [text_block1]) }
        it 'doesnt change blocks' do
         filter = BlockProximityFusion.new(1, false, false)
         expect(filter.process(doc)).to be false
        end
      end

      context 'When content_only is specified but no content exists' do
        before do
          text_block1.content = false
          text_block2.content = false
          text_block3.content = false
          text_block4.content = false
        end
        it 'doesnt change blocks' do
         filter = BlockProximityFusion.new(1, true, false)
         expect(doc.text_blocks.size).to eq 4
         filter.process(doc)
         expect(doc.text_blocks.size).to eq 4
        end
      end

      context 'when same tag level is specified but tag levels arent the same' do
        before do
          text_block1.set_tag_level 1
          text_block2.set_tag_level 2
          text_block3.set_tag_level 3
          text_block3.set_tag_level 4
        end
        it 'doesnt change blocks' do
          expect(doc.text_blocks.size).to be 4
          filter = BlockProximityFusion.new(1, false, true)
          filter.process(doc)
          expect(doc.text_blocks.size).to be 4
        end
      end
    end
  end
end
