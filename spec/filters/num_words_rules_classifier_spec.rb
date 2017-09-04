require 'spec_helper'

module Boilerpipe::Filters
  describe NumWordsRulesClassifier do
    let(:tb) { Boilerpipe::Document::TextBlock }
    let(:doc) { Boilerpipe::Document::TextDocument.new '', text_blocks }

    describe '#process' do
      it 'processes a text document'
      context 'with a content text block' do
        let(:text_blocks) do
          [
            tb.new('What a great day!'),
            tb.new('What a terrible day! oh no no no no no no no no no no no no no', 16)
          ]
        end


        it 'labels the text block as content' do
          NumWordsRulesClassifier.process(doc)
          expect(doc.text_blocks.first.is_content?).to be true
        end
      end

      context 'with a non-content text block' do
        let(:text_blocks) do
          [
            tb.new('What a great day!'),
            tb.new('What a great day!', 4)
          ]
        end

        it 'labels the text block as non-content' do
          NumWordsRulesClassifier.process(doc)
          expect(doc.text_blocks.first.is_content?).to be false
        end
      end
    end
  end
end
