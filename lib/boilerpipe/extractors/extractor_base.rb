class ExtractorBase < BoilerpipeExtractor
  def get_text(param)
    case param
    when String
      method_for_String(param)
    when Type1
      method_for_Type1(param)
    else
      #default implementation
    end
  end

  def get_text_from_url(url)
  end

  def get_text_from_html(html)
    BoilerPipeSAXInput.new(html).text_document
  end

#  public String getText(final String html) throws BoilerpipeProcessingException {
#    try {
#      return getText(new BoilerpipeSAXInput(new InputSource(new StringReader(html)))
#          .getTextDocument());
#    } catch (SAXException e) {
#      throw new BoilerpipeProcessingException(e);
#    }
#  }
#
#  public String getText(final InputSource is) throws BoilerpipeProcessingException {
#    try {
#      return getText(new BoilerpipeSAXInput(is).getTextDocument());
#    } catch (SAXException e) {
#      throw new BoilerpipeProcessingException(e);
#    }
#  }

  def get_text_from_input_source(source)
    # nokogiri something or other sax
  end
end
