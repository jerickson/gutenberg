require "spec_helper"

module Gutenberg
  describe MobyDickParser do

    before :each do
      @mobydick = MobyDickParser.new()
    end

    it 'should parse all chapters' do
      @mobydick.parse().count().should == 138
    end

    it 'should start with famous first line' do
      chapters = @mobydick.parse()
      chapter1 = chapters[2]
      paragraph1 = chapter1.paragraphs.first
      paragraph1.start_with?("Call me Ishmael.").should == true
    end

  end
end
