module Boilerpipe::SAX::TagActions
  describe InlineWhitespace do
    describe '#start' do
      it 'adds whitespace if needed' do
        handler = double('handler')
        expect(handler).to receive(:append_space)
        subject.start(handler, nil, nil)
      end
      it 'returns false' do
        handler = double('handler')
        expect(handler).to receive(:append_space)
        expect(subject.start(handler, nil, nil)).to be false
      end
    end

    describe '#end_tag' do
      it 'adds whitespace if needed' do
        handler = double('handler')
        expect(handler).to receive(:append_space)
        subject.end_tag(handler, nil)
      end
      it 'returns false' do
        handler = double('handler')
        expect(handler).to receive(:append_space)
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
