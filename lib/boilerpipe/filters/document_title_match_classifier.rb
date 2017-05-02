# encoding: utf-8
require 'set'
module Boilerpipe::Filters
  class DocumentTitleMatchClassifier

    def initialize(title)
      @potential_titles = Set.new
      return if title.nil?
      title = title.gsub('\u00a0', ' ')
        .gsub("'", "")
        .strip
        .downcase
      @potential_titles << title

      p = longest_part(title, "[ ]*[\\|»|-][ ]*")
      @potential_titles << p if p

      p = longest_part(title, "[ ]*[\\|»|:][ ]*")
      @potential_titles << p if p

      p = longest_part(title, "[ ]*[\\|»|:\\(\\)][ ]*")
      @potential_titles << p if p

      p = longest_part(title, "[ ]*[\\|»|:\\(\\)\\-][ ]*")
      @potential_titles << p if p

      p = longest_part(title, "[ ]*[\\|»|,|:\\(\\)\\-][ ]*")
      @potential_titles << p if p

      p = longest_part(title, "[ ]*[\\|»|,|:\\(\\)\\-\u00a0][ ]*")
      @potential_titles << p if p

      add_potential_titles(title, "[ ]+[\\|][ ]+", 4)
      add_potential_titles(title, "[ ]+[\\-][ ]+", 4)

      @potential_titles << title.sub(" - [^\\-]+$", "")
      @potential_titles << title.sub("^[^\\-]+ - ", "")
    end

    # regex?
    #PAT_REMOVE_CHARACTERS = Pattern.compile("[\\?\\!\\.\\-\\:]+");

    def process(doc)
      return false if @potential_titles.empty?
      changes = false

      doc.text_blocks.each do |tb|
        text = tb.text
        text.gsub!('\u00a0', ' ')
          .gsub!("'", "")
          .strip!.downcase!

        if @potential_titles.contains(text)
          tb.add_label(DefaultLabels::TITLE)
          changes = true
          break
        end

        #text = PAT_REMOVE_CHARACTERS.matcher(text).gsub("").trim
        if @potential_titles.contains(text)
          tb.add_label(DefaultLabels::TITLE)
          changes = true
          break
        end

      end
      changes
    end

    private
    def longest_part(title, regex)
      parts = title.split(pattern)
      return nil if parts.size == 1

      longest_num_words = 0
      longest_part = ''

      parts.each do |part|
        next if part.contains('.com')

        num_words = part.split("[\b ]+").size
        if num_words > longest_num_words || part.size > lonngest_part.size
          longest_num_words = num_words
          longest_part = part
        end
      end

      longest_part.empty? ? nil : longest_part.strip
    end

    def add_potential_titles(potential_titles, title, pattern, min_words)
      parts = title.split(pattern)
      return if parts.size == 1

      parts.each do  |part|
        next if part.contains('.com')
        num_words = p.split("[\b ]+").size
        @potential_titles << if num_words >= min_words
        end
      end
    end
  end
end
