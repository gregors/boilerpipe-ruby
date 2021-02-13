require 'spec_helper'

module Boilerpipe
  describe SAX::Preprocessor do
    it 'strips script tags' do
      text = "\n\t\t<script type=\"text/javascript\">\n\t\t\twindow._wpemojiSettings</script>boom"
      output = SAX::Preprocessor.strip(text)
      expect(output).to eq "\n\t\tboom"
    end

    it 'doesnt take too much' do
      text = "\n\t\t<script type=\"text/javascript\">\n\t\t\twindow._wpemojiSettings</script>boom<script>alert()</script>"
      output = SAX::Preprocessor.strip(text)
      expect(output).to eq "\n\t\tboom"
    end
  end
end
