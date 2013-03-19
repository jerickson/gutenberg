module Gutenberg
  class Paragraph
    
    attr_reader :text

    def initialize(text)
      @text = text.strip()
    end

    def has_text?
      return !@text.empty?
    end

    def starts_with?(token)
      return @text.start_with?(token)
    end
      
    def end_of_book?
      return starts_with?("*** END")
    end
  end
end
