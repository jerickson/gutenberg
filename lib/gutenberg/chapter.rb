module Gutenberg
  class Chapter

    NULL = "Null.Object"

    attr_reader :paragraphs
    attr_accessor :title
    
    def initialize(header)
      @header = header
      @title = header
      @paragraphs = []
    end

    def begins_with?(text)
      return text.starts_with?(@header)
    end

    def add(paragraph)
      @paragraphs << paragraph
    end

    def is_null?
      return @header == NULL
    end

    def self.null()
      return Chapter.new(NULL) 
    end
    
  end
end
