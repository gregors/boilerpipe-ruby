require 'spec_helper'

module Boilerpipe::Filters
  describe TrailingHeadlineToBoilerplateFilter do
    let(:text) { 'What a great day! This is great! Yes! Ha ha' }
    let(:tb) { Boilerpipe::Document::TextBlock.new text }
    let(:doc) { Boilerpipe::Document::TextDocument.new '', [tb] }

    describe '#process' do
      context 'when a text block is content' do
        before { tb.content = true }

        context 'and has a HEADING label' do
          before { tb.add_label(:HEADING) }

          it 'sets the text block content to false' do
            TrailingHeadlineToBoilerplateFilter.process(doc)
            expect(doc.text_blocks.first.content).to be false
          end
        end

        context 'and does not have a HEADING label' do
          it 'does not change the content to false' do
            TrailingHeadlineToBoilerplateFilter.process(doc)
            expect(doc.text_blocks.first.content).to be true
          end
        end
      end
    end
  end
end
