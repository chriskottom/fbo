require 'spec_helper'

describe FBO::File do
  describe 'class methods' do
    subject   { FBO::File }

    describe 'filename_for_date' do
      it 'should raise an exception when no date is given' do
        proc { subject.filename_for_date(nil) }.must_raise ArgumentError
      end

      it 'returns the right file name for a given date' do
        date = Date.parse('2013-07-08')
        subject.filename_for_date(date).must_equal 'FBOFeed20130708'
      end
    end
  end

  context 'non-existent file' do
    subject          { FBO::File.new('foobar.bat') }

    it 'raises an exception' do
      proc { subject.readline }.must_raise Errno::ENOENT
    end
  end

  context 'existing file' do
    let(:filename)   { File.join(File.dirname(__FILE__), '..', 'fixtures', 'FBOFeed20130331') }
    subject          { FBO::File.new(filename) }

    it 'enables access to file contents' do 
      subject.contents.must_be_instance_of String
      subject.contents.wont_be_empty
      subject.contents.must_match /^<PRESOL>\n<DATE>0331/
    end
  end
end
