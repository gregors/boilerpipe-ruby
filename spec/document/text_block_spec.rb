require 'spec_helper'

module Boilerpipe
  describe Document::TextBlock do
    subject { Document::TextBlock.new 'hello' }
    describe '.new' do
      context 'with text input' do
        it 'sets text' do
          expect(subject.text).to eq 'hello'
        end

        # used in image extraction / highligher
        # not yet implemented
        it 'bit set of containedTextElements'

        it 'sets number of words' do
          expect(subject.num_words).to eq 0
        end

        it 'number of words in anchor text' do
          expect(subject.num_words_in_anchor_text).to eq 0
        end

        it 'number of words in wrapped lines' do
          expect(subject.num_words_in_wrapped_lines).to eq 0
        end

        it 'number of wrapped lines' do
          expect(subject.num_wrapped_lines).to eq 1
        end

        it 'offset blocks' do
          expect(subject.offset_blocks_start).to eq 0
          expect(subject.offset_blocks_end).to eq 0
        end

        it 'link_density' do
          expect(subject.link_density).to eq 0
        end

        it 'text_density' do
          expect(subject.text_density).to eq 0
        end
      end
    end

    describe '#merge_next' do
      it 'merges another TextBlock' do
        another_block = Document::TextBlock.new 'good-bye'
        subject.merge_next(another_block)
        expect(subject.text).to eq "hello\ngood-bye"
      end

      it 'num words gets combined' do
        another_block = Document::TextBlock.new('good-bye', 1)
        subject.merge_next(another_block)
        expect(subject.num_words).to eq 1
      end
    end

    describe '#add_label' do
      it 'adds a label' do
        expect { subject.add_label('another label') }.to change { subject.labels.size }.by(1)
      end
    end

    describe '#add_labels' do
      it 'adds a set of labels' do
        labels = Set.new([1, 2, 3])
        expect { subject.add_labels(labels) }.to change { subject.labels.size }.by(3)
      end
    end

    describe '#has_label' do
      it 'returns true if it exists' do
        subject.add_label('label 1')
        expect(subject.has_label?('label 1')).to be
      end

      it 'returns false if it does not exist' do
        expect(subject.has_label?('label 1')).to_not be
      end
    end

    describe '#remove_label' do
      it 'removes the label' do
        subject.add_label('label 1')
        expect(subject.labels.size).to eq 1
        subject.remove_label('label 1')
        expect(subject.labels.size).to eq 0
      end
    end

    describe '#is_content?' do
      it 'returns true if content'
      it 'returns false if not content'
    end

    describe '#is_content = ' do
      it 'sets the content flag'
    end

    describe '#clone' do
      it 'clones the TextBlock'
    end

    describe '#is_content?' do
    end
    it ''
    it ''
  end
end
