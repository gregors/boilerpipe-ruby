# encoding: utf-8

 # Marks TextBlocks which contain parts of the HTML <TITLE> tag, using
 # some heuristics which are quite specific to the news domain.

    # we create a list of potential titles from the page title
    # then we look at every text block and if the text block
    # contains a potential title - we set that text block label as :TITLE

module Boilerpipe::Filters
  class DocumentTitleMatchClassifier
    attr_reader :potential_titles

    def initialize(title)
      @potential_titles = Set.new
      generate_potential_titles(title)
    end

    def process(doc)
      return doc if @potential_titles.empty?

      doc.text_blocks.each do |tb|
        text = tb.text.gsub('\u00a0', ' ')
          .gsub("'", '')
          .strip.downcase

        if @potential_titles.member? text
          tb.add_label :TITLE
          break
        end

        remove_characters = /[?!.-:]+/
        text = text.gsub(remove_characters, '').strip

        if @potential_titles.member? text
          tb.add_label :TITLE
          break
        end
      end

      doc
    end

    private

    def generate_potential_titles(title)
      return if title.nil?

      title = title.gsub('\u00a0', ' ')
        .gsub("'", '')
        .strip
        .downcase

      @potential_titles << title

      # unnecessary
      #p = longest_part(title, /[ ]*[|»-][ ]*/)
      #@potential_titles << p if p

      #p = longest_part(title, /[ ]*[|»:][ ]*/)
      #@potential_titles << p if p

      #p = longest_part(title, /[ ]*[|»:()][ ]*/)
      #@potential_titles << p if p

      #p = longest_part(title, /[ ]*[|»:()-][ ]*/)
      #@potential_titles << p if p

      p = longest_part(title, /[ ]*[|»,:()-][ ]*/)
      @potential_titles << p if p

      # we replace \u00a0 so why check for it?
      #p = longest_part(title, /[ ]*[|»,:()-\u00a0][ ]*/)
      #@potential_titles << p if p

      add_potential_titles(title, /[ ]+[|][ ]+/, 4)
      add_potential_titles(title, /[ ]+[-][ ]+/, 4)

      @potential_titles << title.sub(/ - [^-]+$/, '') # remove right of -
      @potential_titles << title.sub(/^[^-]+ - /, '') # remove left of -
    end

    def longest_part(title, regex)
      parts = title.split regex
      return nil if parts.size == 1

      longest_num_words = 0
      longest_part = ''

      parts.each do |part|
        next if part =~ /[.]com/
        num_words = number_of_words(part)

        if num_words > longest_num_words || part.size > longest_part.size
          longest_num_words = num_words
          longest_part = part
        end
      end

      longest_part.empty? ? nil : longest_part.strip
    end

    def add_potential_titles(title, regex, min_words)
      parts = title.split regex
      return if parts.size == 1

      parts.each do |part|
        next if part =~ /[.]com/
        num_words = number_of_words(part)

        @potential_titles << part if num_words >= min_words
      end
    end

    def number_of_words(s)
      s.split(/[\b ]+/).size
    end

  end
end
