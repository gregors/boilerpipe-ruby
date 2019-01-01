require 'spec_helper'

module Boilerpipe::Labels
  describe Default do
    it 'has markup prefix' do
      expect(Boilerpipe::Labels::Default::MARKUP_PREFIX).to eq '<'
    end
  end
end
