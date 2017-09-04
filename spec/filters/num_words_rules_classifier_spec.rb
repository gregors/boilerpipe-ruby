require 'spec_helper'

module Boilerpipe::Filters
  describe NumWordsRulesClassifier do
    describe '#process' do
      it 'processes a text document'
      context 'with a content text block' do
        let(:tb) { Boilerpipe::Document::TextBlock }
        let(:text_blocks) do
          [
            tb.new('What a great day!'),
            tb.new('What a terrible day! oh no no no no no no no no no no no no no', 16)
          ]
        end

        let(:doc) do
          Boilerpipe::Document::TextDocument.new '', text_blocks
        end

        it 'labels the text block as content' do
          NumWordsRulesClassifier.process(doc)
          expect(doc.text_blocks.first.is_content?).to be true
        end
      end

      context 'with a non-content text block' do
        it 'labels the text block as non-content'
      end
    end
  end
end
