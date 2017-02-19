require 'spec_helper'

module Boilerpipe::SAX::TagActions
  describe BlockTagLabel do
    let(:subject){ BlockTagLabel.new(nil) }
    let(:handler) { ::Boilerpipe::SAX::HTMLContentHandler.new }

    describe '.new' do
      it 'takes a label action'
    end
    describe '#start' do
      it 'returns true' do
        expect(subject.start(handler, nil, nil)).to be true
      end
    end
    describe '#end_tag' do
      it 'returns true' do
        expect(subject.end_tag(handler, nil)).to be true
      end
    end
    describe '#changes_tag_level?' do
      it 'returns true' do
        expect(subject.changes_tag_level?).to be true
      end
    end
  end
end
