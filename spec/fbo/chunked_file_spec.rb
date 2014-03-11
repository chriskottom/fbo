require 'spec_helper'

describe FBO::ChunkedFile do
  let(:filename)   { File.join(File.dirname(__FILE__), '..', 'fixtures', 'FBOFeed20131013') }
  let(:file)       { FBO::File.new(filename) }
  let(:chunk_size) { 25 * 1024 }   # 25KB
  subject          { FBO::ChunkedFile.new(file, chunk_size) }

  describe '#contents' do
    it 'returns an Array of String' do
      subject.contents.must_be_instance_of Array
      subject.contents.each { |x| x.must_be_instance_of String }
    end

    it 'returns chunks that include whole notices' do
      contents = subject.contents
      contents.each do |chunk|
        chunk.must_match FBO::NOTICE_CLOSE_REGEXP
      end
    end
  end
end
