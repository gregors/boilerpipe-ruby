class BoilerpipeHTMLParser
 # this is the class which extends abstract sax parser in java
  def initialize
    @handler = BoilerpipeHTMLContentHandler.new
  end

  def parse
     # this must be in the base abstract class 
  end

 #* Returns a {@link TextDocument} containing the extracted {@link TextBlock} s. NOTE: Only call
 #  * this after {@link #parse(org.xml.sax.InputSource)}.
 #  * 
  def text_document
    @handler.text_document
  end
end
