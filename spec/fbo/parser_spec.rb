require 'spec_helper'

describe FBO::Parser do
  context 'a single data String' do
    let(:contents) { "<PRESOL>\n</PRESOL>\n<COMBINE>\n</COMBINE>\n<AMDCSS>\n</AMDCSS>\n" }
    let(:file)     { stub('FBO::File', contents: contents) }
    subject        { FBO::Parser.new(file) }

    it 'parses the data all at once' do
      subject.expects(:parse_string).with(file.contents)
      subject.parse
    end

    it 'returns a tree representing all notices' do
      tree = subject.parse
      tree.must_be_instance_of FBO::Dump::DumpNode

      notice_types = tree.elements.map { |e| e.class.name }.sort
      notice_types.must_equal [ 'FBO::Dump::AmendmentNode',
                                'FBO::Dump::CombinedSolicitationNode',
                                'FBO::Dump::PresolicitationNode' ]
    end
  end

  context 'a collection of data Strings' do
    let(:contents) { [ '<PRESOL></PRESOL>', '<COMBINE></COMBINE>', '<AMDCSS></AMDCSS>' ] }
    let(:file)     { stub('FBO::ChunkedFile', contents: contents) }
    subject        { FBO::Parser.new(file) }

    it 'parses the collection' do
      subject.expects(:parse_collection).with(contents)
      subject.parse
    end

    it 'parses each data chunk individually' do
      contents.each do |string|
        subject.expects(:parse_string).with(string)
      end
      subject.parse
    end

    it 'returns a unified tree representing all notices' do
      tree = subject.parse
      tree.must_be_instance_of FBO::Dump::DumpNode

      notice_types = tree.elements.map { |e| e.class.name }.sort
      notice_types.must_equal [ 'FBO::Dump::AmendmentNode',
                                'FBO::Dump::CombinedSolicitationNode',
                                'FBO::Dump::PresolicitationNode' ]
    end
  end

  context 'a bad String' do
    let(:contents) { "<PRESOL>\n</PRESOL>\n<COMBINE>\n<COMBINE>\n</COMBINE>\n<AMDCSS>\n</AMDCSS>\n" }
    let(:file)     { stub('FBO::File', contents: contents) }
    subject        { FBO::Parser.new(file) }

    it 'raises a ParserError' do
      proc { subject.parse }.must_raise FBO::ParserError
    end
  end

  context 'a collection of data with a bad String' do
    let(:contents) { [ '<PRESOL></PRESOL>', '<COMBINE><COMBINE></COMBINE>', '<AMDCSS></AMDCSS>' ] }
    let(:file)     { stub('FBO::ChunkedFile', contents: contents) }
    subject        { FBO::Parser.new(file) }

    it 'raises a ParserError' do
      proc { subject.parse }.must_raise FBO::ParserError
    end
  end
end
