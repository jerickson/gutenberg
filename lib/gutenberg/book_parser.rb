module Gutenberg
  class BookParser

    def initialize(file, chapters)
      @file = file
      @chapters = chapters.reverse.map{|c| Chapter.new(c)}
      @next = Chapter.null()
      @current = Chapter.null()
      @parsed = []
    end

    def parse
      @next = get_next_chapter()
      self.paragraphs().each do |paragraph|
        break if paragraph.end_of_book?
        if paragraph.has_text?
          if @next.begins_with?(paragraph)
            start_next_chapter(paragraph) 
          else
            @current.add(paragraph)
          end
        end
      end 
      return @parsed
    end

    def start_next_chapter(paragraph)
      @current = @next
      @current.title = paragraph.text
      @parsed << @current if !@current.is_null?
      @next = get_next_chapter()
    end
    
    def paragraphs
      file_text = @file.read()
      paragraphs = file_text.split("\n\n")
      return paragraphs.map{ |p| Paragraph.new(p) }
    end

    def get_next_chapter
      return @chapters.empty? ? Chapter.null() : @chapters.pop()
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
