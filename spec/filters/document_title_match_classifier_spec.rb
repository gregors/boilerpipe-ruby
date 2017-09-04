require 'spec_helper'

module Boilerpipe::Filters
  describe DocumentTitleMatchClassifier do
    let(:input) { 'Extracting Text For Fun And Profit - Greg' }
    subject { DocumentTitleMatchClassifier.new input }

    describe '.new' do
      context 'takes a string with a title' do
        it 'makes potential titles' do

          expected = [
            'extracting text for fun and profit - greg',
            'extracting text for fun and profit',
            'greg'
          ]
          expect(subject.potential_titles.to_a).to eq expected
        end
      end
    end

    describe '#process' do
      context 'has a text document with a title' do
        let(:text_blocks) do
          [
            Boilerpipe::Document::TextBlock.new('What a great day!'),
            Boilerpipe::Document::TextBlock.new('What a terrible day!'),
            Boilerpipe::Document::TextBlock.new(input)
          ]
        end

        let(:doc) do
          Boilerpipe::Document::TextDocument.new(input, text_blocks)
        end

        it 'marks a text block as :TITLE' do
          subject.process(doc)
          expect(text_blocks.last.labels.first).to eq :TITLE
        end
      end
    end

    describe '#potential_titles'

    # these are private but let's start with testing to get parity
    describe '#longest_part'
  end
end
