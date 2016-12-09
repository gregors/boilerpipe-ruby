class Parser < Nokogiri::XML::SAX::Document
  def start_element(name, attrs = [])
    puts "start element #{name}"
    # Handle each element, expecting the name and any attributes
  end

  def characters(string)
    #puts "character #{string}"
    # Any characters between the start and end element expected as a string
  end

  def end_element(name)
    puts "end element #{name}"
    # Given the name of an element once its closing tag is reached
  end
end
