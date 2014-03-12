require 'spec_helper'

describe FBO::Interpreter do
  let(:filename)  { File.join(File.dirname(__FILE__), '..', 'fixtures', 'FBOFeed20130331') }
  let(:actor)     { MiniTest::Mock.new }

  describe '#each_notice' do
    let(:file) { FBO::File.new(filename) }
    subject    { FBO::Interpreter.new(file) }

    it 'acts eight times - once on each notice' do
      8.times { actor.expect(:process, nil, [String, Treetop::Runtime::SyntaxNode ]) }
      subject.each_notice { |str, struct| actor.process(str, struct) }
      actor.verify
    end
  end

  describe '#next_notice' do
    let(:file) { FBO::File.new(filename) }
    subject    { FBO::Interpreter.new(file) }

    it 'acts on the first notice' do
      actor.expect(:process, nil, [String, Treetop::Runtime::SyntaxNode ])
      string, structure = subject.next_notice { |str, struct| actor.process(str, struct) }
      actor.verify

      string.must_match /^\<PRESOL\>/
      string.must_match /\<SOLNBR\>SPE4A713R0795/
      structure.type.must_equal :presol
      structure.to_hash[:solicitation_number].must_equal 'SPE4A713R0795'
    end
  end
end
