module Gutenberg
  class BookParser
    
    END_OF_BOOK = "*** END OF THIS PROJECT GUTENBERG EBOOK"

    def initialize(file, chapters)
      @file = file
      @chapters = chapters.reverse.map{|c| Chapter.new(c)}
      @next = nil
      @current = nil
      @parsed = []
    end

    def parse
      @next = get_next_chapter()
      self.paragraphs().each do |paragraph|
        break if paragraph.start_with?(END_OF_BOOK)
        if !paragraph.empty?
          if @next && @next.begins_with?(paragraph)
            start_next_chapter(paragraph) 
          else
            @current.add(paragraph) if !@current.nil?
          end
        end
      end 
      return @parsed
    end
    
    def paragraphs
      file_text = @file.read()
      paragraphs = file_text.split("\n\n")
      return paragraphs.map{ |p| p.strip() }
    end

    private 

    def start_next_chapter(paragraph)
      @current = @next
      @current.title = paragraph
      @parsed << @current if !@current.nil?
      @next = get_next_chapter()
    end
    
    def get_next_chapter
      return @chapters.empty? ? nil : @chapters.pop()
    end

  end


  class MobyDickParser < BookParser
    
    def initialize()
      super(get_file(), get_chapters())
    end

    def get_file()
      return File.new('files/moby.txt', 'r')
    end

    def get_chapters()
      chapters = [] 
      chapters << 'ETYMOLOGY.'
      chapters << 'EXTRACTS (Supplied by a Sub-Sub-Librarian).'
      135.times.each do |i|
        chapters << "CHAPTER #{i+1}."
      end
      chapters << 'Epilogue'
      return chapters
    end

  end

end
