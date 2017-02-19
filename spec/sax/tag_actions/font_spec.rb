require 'spec_helper'

module Boilerpipe::SAX::TagActions
  describe Font do
    describe '#start' do
      it 'returns false' do
        handler = ::Boilerpipe::SAX::HTMLContentHandler.new
        expect(subject.start(handler, nil, {})).to be false
      end
      context 'with a font size' do
        it 'sets absolute' do
          handler = ::Boilerpipe::SAX::HTMLContentHandler.new
          handler.font_size_stack.clear
          subject.start(handler, nil, {'size' => '4'})
          expect(handler.font_size_stack).to eq [4]
        end

        it 'sets relative' do
          handler = ::Boilerpipe::SAX::HTMLContentHandler.new
          handler.font_size_stack.clear
          subject.start(handler, nil, {'size' => '+4'})
          expect(handler.font_size_stack).to eq [7]
        end

        it 'sets relative with a previous value' do
          handler = ::Boilerpipe::SAX::HTMLContentHandler.new
          handler.font_size_stack.clear
          handler.font_size_stack << 1
          handler.font_size_stack << nil
          subject.start(handler, nil, {'size' => '+4'})
          expect(handler.font_size_stack).to eq [1, nil, 5]
        end

        it 'adds size to font stack' do
          handler = ::Boilerpipe::SAX::HTMLContentHandler.new
          handler.font_size_stack.clear
          subject.start(handler, nil, {'size' => '3'})
          expect(handler.font_size_stack).to eq [3]
        end
      end
      context 'without a font size' do
        it 'adds nil to font stack' do
          handler = ::Boilerpipe::SAX::HTMLContentHandler.new
          handler.font_size_stack.clear
          subject.start(handler, nil, {})
          expect(handler.font_size_stack).to eq [nil]
        end
      end
    end
    describe '#end_tag' do
      it 'pops last font size from stack' do
        handler = ::Boilerpipe::SAX::HTMLContentHandler.new
        handler.font_size_stack << 5
        subject.end_tag(handler, nil)
        expect(handler.font_size_stack).to be_empty
      end

      it 'returns false' do
        handler = ::Boilerpipe::SAX::HTMLContentHandler.new
        expect(subject.end_tag(handler, nil)).to be false
      end
    end
    describe '#changes_tag_level?' do
      it 'returns false' do
        expect(subject.changes_tag_level?).to be false
      end
    end
  end
end
