# Finds blocks which are potentially indicating the end of an article
# text and marks them with INDICATES_END_OF_TEXT. This can be used
# in conjunction with a downstream IgnoreBlocksAfterContentFilter.

module Boilerpipe::Filters
  class TerminatingBlocksFinder
    def self.process(doc)
      doc.text_blocks.each do |tb|
        next unless tb.num_words < 15

        if tb.text.length >= 8 && finds_match?(tb.text.downcase)
          tb.labels << :INDICATES_END_OF_TEXT
        elsif tb.link_density == 1.0 && tb.text == 'comment'
          tb.labels << :INDICATES_END_OF_TEXT
        end
      end

      doc
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
        # TODO add this and test
        # text.include?('leave a reply') ||
        # text.include?('leave a comment') ||
        # text.include?('show comments') ||
        # text.include?('Share this:') ||
        text.include?('reader views') ||
        text.include?('have your say') ||
        text.include?('reader comments') ||
        text.include?('rätta artikeln') ||
        text == 'thanks for your comments - this feedback is now closed'
    end
  end
end
