require 'spec_helper'

module Boilerpipe::Labels
  describe LabelAction do
    describe '.new' do
      it 'accepts labels' do
        la = LabelAction.new(['one', 'two'])
        expect(la).to be
      end

      it 'defaults empty labels' do
        la = LabelAction.new
        expect(la).to be
        expect(la.labels).to eq []
      end
    end

    describe '#labels' do
      it 'returns labels' do
        la = LabelAction.new(['one', 'two'])
        expect(la.labels).to eq ['one', 'two']
      end
    end

    describe '#add_to' do
      it 'adds labels to textblock'
    end

    describe '#to_s' do
      it 'returns debug string' do
        la = LabelAction.new(['one', 'two'])
        expect(la.to_s).to eq 'one,two'
      end
    end
  end
end
