require "spec_helper"

module Gutenberg
  describe BookParser do

    before :each do
      filestub = build_file_stub()

      chapters = [ "CHAPTER 1.",
                   "CHAPTER 2.",
                   "CHAPTER 3." ]

      @parser = BookParser.new(filestub, chapters)
    end

    it 'should parse all chapters' do
      @parser.parse().count().should == 3
    end

    it 'should parse all paragraphs' do
      @parser.paragraphs().count().should == 20
    end

    it 'should parse chapters in order' do
      chapters = @parser.parse()
      chapters[0].title.should == "CHAPTER 1."
      chapters[1].title.should == "CHAPTER 2."
      chapters[2].title.should == "CHAPTER 3."
    end

    it 'should parse chapter 1' do
      chapters = @parser.parse()
      ch1 = chapters.first
      ch1.paragraphs.count.should == 5
      ch1.paragraphs[0].should == "Paragraph 1 in Chapter 1."
      ch1.paragraphs[1].should == "Paragraph 2 in Chapter 1."
      ch1.paragraphs[2].should == "Paragraph 3 in Chapter 1."
      ch1.paragraphs[3].should == "Paragraph 4 in Chapter 1."
      ch1.paragraphs[4].should == "Paragraph 5 in Chapter 1."
    end

    it 'should parse chapter 2' do
      chapters = @parser.parse()
      ch2 = chapters[1]
      ch2.paragraphs.count.should == 4
      ch2.paragraphs[0].should == "Paragraph 1 in Chapter 2."
      ch2.paragraphs[1].should == "Paragraph 2 in Chapter 2."
      ch2.paragraphs[2].should == "Paragraph 3 in Chapter 2."
      ch2.paragraphs[3].should == "Paragraph 4 in Chapter 2."
    end

    it 'should parse chapter 3' do
      chapters = @parser.parse()
      ch3 = chapters[2]
      ch3.paragraphs.count.should == 6
      i = 0
      ch3.paragraphs.each do |paragraph|
        paragraph.should == "Paragraph #{i+=1} in Chapter 3."
      end
    end


    private

    def build_file_stub()
      text = "Moby Spec\n\n"
      text << "CHAPTER 1.\n\n"
      text << "Paragraph 1 in Chapter 1.\n\n"
      text << "Paragraph 2 in Chapter 1.\n\n"
      text << "Paragraph 3 in Chapter 1.\n\n"
      text << "Paragraph 4 in Chapter 1.\n\n"
      text << "Paragraph 5 in Chapter 1.\n\n"
      text << "CHAPTER 2.\n\n"
      text << "Paragraph 1 in Chapter 2.\n\n"
      text << "Paragraph 2 in Chapter 2.\n\n"
      text << "Paragraph 3 in Chapter 2.\n\n"
      text << "Paragraph 4 in Chapter 2.\n\n"
      text << "CHAPTER 3.\n\n"
      text << "Paragraph 1 in Chapter 3.\n\n"
      text << "Paragraph 2 in Chapter 3.\n\n"
      text << "Paragraph 3 in Chapter 3.\n\n"
      text << "Paragraph 4 in Chapter 3.\n\n"
      text << "Paragraph 5 in Chapter 3.\n\n"
      text << "Paragraph 6 in Chapter 3.\n\n"
      text << "*** END OF THIS PROJECT GUTENBERG EBOOK"
      return stub :read => text
    end
  end
end
