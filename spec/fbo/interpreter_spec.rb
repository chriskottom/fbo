require 'spec_helper'

describe FBO::Interpreter do
  let(:filename)  { File.join(File.dirname(__FILE__), '..', 'fixtures', 'FBOFeed20130331') }
  let(:file)      { FBO::File.new(filename) }
  let(:actor)     { stub('Act on ALL the Notices', process: nil) }

  context 'with input FBO::File' do
    subject  { FBO::Interpreter.new(file) }

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

    describe '#each_special_notice' do
      it 'does nothing (no SNOTE notices)' do
        actor.expects(:process).never
        subject.each_special_notice { |n| actor.process(n) }
      end
    end
  end

  context 'with input FBO::ChunkedFile' do
    let(:chunked)   { FBO::ChunkedFile.new(file) }
    subject         { FBO::Interpreter.new(chunked) }

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

    describe '#each_special_notice' do
      it 'does nothing (no SNOTE notices)' do
        actor.expects(:process).never
        subject.each_special_notice { |n| actor.process(n) }
      end
    end
  end

  context 'with input FBO::SegmentedFile' do
    let(:segmented) { FBO::SegmentedFile.new(file) }
    subject         { FBO::Interpreter.new(segmented) }

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

    describe '#each_special_notice' do
      it 'does nothing (no SNOTE notices)' do
        actor.expects(:process).never
        subject.each_special_notice { |n| actor.process(n) }
      end
    end
  end
end
