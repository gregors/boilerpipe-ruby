# encoding: utf-8

    # Fuses adjacent blocks if their distance (in blocks) does not exceed a certain limit. This
    # probably makes sense only in cases where an upstream filter already has removed some blocks.

module Boilerpipe::Filters
  class BlockProximityFusion


    def initialize(max_blocks_distance, content_only, same_tag_level_only)
      @max_blocks_distance = max_blocks_distance
      @content_only = content_only
      @same_tag_level_only = same_tag_level_only
    end

    MAX_DISTANCE_1 = BlockProximityFusion.new(1, false, false)
    MAX_DISTANCE_1_SAME_TAGLEVEL = BlockProximityFusion.new( 1, false, true)
    MAX_DISTANCE_1_CONTENT_ONLY = BlockProximityFusion.new( 1, true, false)
    MAX_DISTANCE_1_CONTENT_ONLY_SAME_TAGLEVEL = BlockProximityFusion.new(1, true, true)

    def process(doc)
      text_blocks = doc.text_blocks
      return false if text_blocks.size < 2

      prev_block = if @content_only
                     text_blocks.find{ |tb| tb.is_content? }
                   else
                     text_blocks.first
                   end

      return false if prev_block.nil?

      offset = text_blocks.index(prev_block)
      blocks = text_blocks[offset..-1]

      blocks_to_remove = []

      combined = blocks.delete_if do |tb|
        prev_block = tb unless tb.is_content?
        next unless tb.is_content?

        diff_blocks = blocks.index(tb) - blocks.index(prev_block)
        next if diff_blocks == 0

        ok = true
        if diff_blocks <= @max_blocks_distance
          ok = false if (prev_block.is_not_content? || tb.is_not_content?) && @content_only
          ok = false if ok && prev_block.tag_level != tb.tag_level && @same_tag_level_only
        end

        # return logic for delete_if
        if ok
          prev_block.merge_next(tb)
          blocks_to_remove << tb
          true # delete current node due to merge
        else
          prev_block = tb
          false # don't delete current node
        end
      end

      doc.replace_text_blocks!(combined)
      doc
    end

  end
end
