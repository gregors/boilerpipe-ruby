require 'spec_helper'

module Boilerpipe::SAX::TagActions
  describe  AnchorText do
    describe '#start' do
      it 'increase in_anchor count' do
        handler = Boilerpipe::SAX::HTMLContentHandler.new
        expect{subject.start(handler, nil, nil)}.to change{handler.in_anchor_tag}.from(0).to(1)
      end

      it 'adds anchor text start' do
        handler = Boilerpipe::SAX::HTMLContentHandler.new
        expect{subject.start(handler, nil, nil)}.to change{handler.token_buffer_size}.from(0).to(4)
      end

      it 'returns false' do
        handler = Boilerpipe::SAX::HTMLContentHandler.new
        expect(subject.start(handler, nil, nil)).to be false
      end
      context 'if in nested anchor tag' do
        it 'calls end_tag' do
          handler = Boilerpipe::SAX::HTMLContentHandler.new
          expect{subject.start(handler, nil, nil)}.to change{handler.in_anchor_tag}.from(0).to(1)
          subject.start(handler, nil, nil)
          expect(handler.in_anchor_tag).to eq(1)
        end
        it 'doesnt append end anchor text' do
          handler = Boilerpipe::SAX::HTMLContentHandler.new
          expect{subject.start(handler, nil, nil)}.to change{handler.in_anchor_tag}.from(0).to(1)
          #puts handler.token_buffer
          expect(handler.token_buffer_size).to eq(4)

          subject.start(handler, nil, nil)
          #puts handler.token_buffer
          expect(handler.token_buffer_size).to eq(4)
        end

      end
    end

      describe '#end_tag' do
        it 'decreases in_anchor count' do
          handler = Boilerpipe::SAX::HTMLContentHandler.new
          handler.in_anchor_tag = 1
          expect{subject.end_tag(handler, nil)}.to change{handler.in_anchor_tag}.from(1).to(0)
        end

        it 'adds end anchor text' do
          handler = Boilerpipe::SAX::HTMLContentHandler.new
          handler.in_anchor_tag = 1
          expect{subject.end_tag(handler, nil)}.to change{handler.token_buffer_size}.from(0).to(4)
        end

        context 'if in nested anchor tag' do
          it 'doesnt add end anchor text' do
            handler = Boilerpipe::SAX::HTMLContentHandler.new
            handler.in_anchor_tag = 2 # means nested
            subject.end_tag(handler, nil)
            expect(handler.token_buffer_size).to eq 0
          end
        end

        context 'if in ignorable element' do
          it 'doesnt add end anchor text' do
            handler = Boilerpipe::SAX::HTMLContentHandler.new
            handler.in_anchor_tag = 1
            handler.instance_variable_set(:@in_ignorable_element, 1)
            subject.end_tag(handler, nil)
            expect(handler.token_buffer_size).to eq 0
          end
        end
      end

      describe '#changes_tag_level' do
        it 'returns true' do
          expect(subject.changes_tag_level).to be true
        end
      end
  end
end
