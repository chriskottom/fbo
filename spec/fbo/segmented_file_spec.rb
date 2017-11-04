require 'spec_helper'

describe FBO::SegmentedFile do
  let(:filename)   { File.join(File.dirname(__FILE__), '..', 'fixtures', 'FBOFeed20131003') }
  let(:file)       { FBO::File.new(filename) }
  subject          { FBO::SegmentedFile.new(file) }

  describe "#contents" do
    it "returns an Array of String" do
      subject.contents.must_be_instance_of Array
      subject.contents.each { |x| x.must_be_instance_of String }
    end

    it "returns chunks that include whole notices" do
      contents = subject.contents
      contents.each do |segment|
        segment.must_match FBO::NOTICE_CLOSE_REGEXP
      end
    end
  end

  describe '#presol_contents' do
    let(:presol_contents)  { subject.presol_contents }

    it 'returns a single big String' do
      presol_contents.must_be_instance_of String
    end

    it 'must start and end with a PRESOL' do
      presol_contents.must_match %r{^<PRESOL>}m
      presol_contents.must_match %r{<\/PRESOL>$}m
    end

    it 'should not contain other notice types' do
      non_presols = FBO::NOTICE_TAG_NAMES - [ 'PRESOL' ]
      regexp_constants = non_presols.map { |name| FBO::SegmentedFile.const_get("#{ name }_REGEXP") }
      regexp_constants.each do |regexp|
        presol_contents.wont_match regexp
      end
    end
  end

  describe '#fstd_contents' do
    it 'returns nil (no content)' do
      subject.fstd_contents.must_be_nil
    end
  end
end
