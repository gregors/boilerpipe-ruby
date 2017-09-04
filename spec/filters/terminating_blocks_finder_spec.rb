require 'spec_helper'

module Boilerpipe::Filters
  describe TerminatingBlocksFinder do
    let(:tb) { Boilerpipe::Document::TextBlock }
    let(:text_blocks) do
      [
        ::Boilerpipe::Document::TextBlock.new(text, 2),
      ]
    end

    let(:doc) { Boilerpipe::Document::TextDocument.new '', text_blocks }

    describe '#process' do
      context 'the text is ending text' do
        let(:text) { 'add comment' }

        it 'adds the ending text label to the text block' do
          TerminatingBlocksFinder.process(doc)
          expect(doc.text_blocks.last.labels.first).to eq :INDICATES_END_OF_TEXT
        end
      end

      context 'the text is not ending text' do
        let(:text) { 'This is not ending text' }

        it 'doesnt add ending text label' do
          TerminatingBlocksFinder.process(doc)
          expect(doc.text_blocks.last.labels.first).to eq nil
        end
      end
    end
  end
end
