# encoding: utf-8
module Boilerpipe::Filters
  class TerminatingBlocksFinder
    def self.process(doc)
      changes = false
      doc.text_blocks.each do |text_block|
        if text_block.num_words < 15
          text = text_block.text.trim.downcase
          if text.length >= 8
            text_block.labels << :INDICATES_END_OF_TEXT if finds_match?(text)
            #seems weird that only this block sets changes to true - bug???
            changes = true
          elsif text_block.link_density == 1.0
            text_block.labels << :INDICATES_END_OF_TEXT if text == 'comment'
          end
        end
      end
      changes
    end

    def self.finds_match?(text)
       text.start_with?('comments') ||
       text =~ /^\d+ (comments|users responded in)/ || # starts with number
       text.start_with?('© reuters') ||
       text.start_with?('please rate this') ||
       text.start_with?('post a comment') ||
       text.include?('what you think...') ||
       text.include?('add your comment') ||
       text.include?('add comment') ||
       text.include?('reader views') ||
       text.include?('have your say') ||
       text.include?('reader comments') ||
       text.include?('rätta artikeln') ||
       text == 'thanks for your comments - this feedback is now closed'
    end
  end
end
