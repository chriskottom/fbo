require 'spec_helper'

describe FBO::Interpreter do
  let(:filename)  { File.join(File.dirname(__FILE__), '..', 'fixtures', 'FBOFeed20130331') }
  let(:file)      { FBO::File.new(filename) }
  let(:tree)      { FBO::Parser.new(file).parse }
  let(:actor)     { stub('Act on ALL the Notices', process: nil) }

  subject         { FBO::Interpreter.new(tree) }

  describe '#each_notice' do
    it 'acts on each notice' do
      actor.expects(:process).with(instance_of(Hash)).times(8)
      subject.each_notice { |n| actor.process(n) }
    end
  end

  describe '#each_presolicitation' do
    it 'acts on each PRESOL notice' do
      actor.expects(:process).with(has_entry(solicitation_number: 'SPE4A713R0795'))
      subject.each_presolicitation { |n| actor.process(n) }
    end
  end

  describe '#each_sources_sought' do
    it 'acts on each SRCSGT notice' do
      actor.expects(:process).with(has_entry(solicitation_number: 'W5J9JE-13-S-0002'))
      subject.each_sources_sought { |n| actor.process(n) }
    end
  end

  describe '#each_combined_solicitation' do
    it 'acts on each COMBINE notice' do
      actor.expects(:process).with(has_entry(solicitation_number: 'SPM7L213TA359'))
      subject.each_combined_solicitation { |n| actor.process(n) }
    end
  end

  describe '#each_amendment' do
    it 'acts on each AMDCSS notice' do
      actor.expects(:process).with(has_entry(solicitation_number: 'SEG30013C0020'))
      subject.each_amendment { |n| actor.process(n) }
    end
  end

  describe '#each_modification' do
    it 'acts on each MOD notice' do
      actor.expects(:process).with(has_entry(solicitation_number: 'SPE4A713R0497'))
      subject.each_modification { |n| actor.process(n) }
    end
  end

  describe '#each_award' do
    it 'acts on each AWARD notice' do
      actor.expects(:process).with(has_entry(solicitation_number: 'SPM4A612R0732'))
      subject.each_award { |n| actor.process(n) }
    end
  end

  describe '#each_document_archival' do
    it 'acts on each ARCHIVE notice' do
      actor.expects(:process).with(has_entry(solicitation_number: 'FA4690-13-B-0001'))
      subject.each_document_archival { |n| actor.process(n) }
    end
  end

  describe '#each_document_unarchival' do
    it 'acts on each UNARCHIVE notice' do
      actor.expects(:process).with(has_entry(solicitation_number: 'SEG30013C0020'))
      subject.each_document_unarchival { |n| actor.process(n) }
    end
  end
end
