module Gutenberg
  class Chapter

    attr_reader :paragraphs
    attr_accessor :title
    
    def initialize(header)
      @header = header
      @title = header
      @paragraphs = []
    end

    def begins_with?(paragraph)
      return paragraph.start_with?(@header)
    end

    def add(paragraph)
      @paragraphs << paragraph
    end
    
  end
end
