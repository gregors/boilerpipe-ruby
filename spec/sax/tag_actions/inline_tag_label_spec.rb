require 'spec_helper'

module Boilerpipe::SAX::TagActions
  describe InlineTagLabel do
    let(:subject) { InlineTagLabel.new(nil) }
    let(:handler) { ::Boilerpipe::SAX::HTMLContentHandler.new }

    describe '.new' do
      it 'takes a label action'
    end
    describe '#start' do
      it 'returns false' do
        expect(subject.start(handler, nil, nil)).to be false
      end
    end
    describe '#end_tag' do
      it 'returns false' do
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
