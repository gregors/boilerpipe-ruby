class BoilerpipeSAXInput
  def initialize(input)
    @input = input
  end

  def text_document
    BoilerpipeHTMLParser.new.parse(@input).text_document
  end 
end
