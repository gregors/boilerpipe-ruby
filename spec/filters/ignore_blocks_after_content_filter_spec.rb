require 'spec_helper'

module Boilerpipe::Filters

  describe IgnoreBlocksAfterContentFilter do
    def content_text_block(s)
      ::Boilerpipe::Document::TextBlock.new(s, 10, 0, 10, 1, 0)
        .tap{|t| t.content = true}
    end

    describe '#process' do
      let(:tb) { Boilerpipe::Document::TextBlock }
      let(:text) { 'What a great day! This is great! Yes! Ha ha' }
      let(:doc) { Boilerpipe::Document::TextDocument.new '', text_blocks }

      context 'with more than 60 words' do
        let(:text_blocks) do
          [
            content_text_block(text),
            content_text_block(text),
            content_text_block(text),
            content_text_block(text),
            content_text_block(text),
            content_text_block(text).tap{|t| t.labels << :INDICATES_END_OF_TEXT},
            content_text_block(text)
          ]
        end


        it 'marks text blocks after end of text labels as non-content' do
          IgnoreBlocksAfterContentFilter.process(doc)
          expect(doc.text_blocks.last.content).to be false
        end
      end

      context 'with less than 60 words' do
        let(:text_blocks) do
          [
            content_text_block(text),
            content_text_block(text).tap{|t| t.labels << :INDICATES_END_OF_TEXT},
            content_text_block(text)
          ]
        end

        it 'does not mark text blocks after end of text' do
          IgnoreBlocksAfterContentFilter.process(doc)
          expect(doc.text_blocks.last.content).to be true
        end
      end

    end
  end
end
