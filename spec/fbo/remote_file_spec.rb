require 'spec_helper'

describe FBO::RemoteFile do
  let(:date)     { Date.parse('2013-03-31') }
  let(:filename) { FBO::RemoteFile.filename_for_date(date) }
  let(:tmp_dir)  { File.join(File.dirname(__FILE__), '..', 'fixtures') }
  let(:ftp)      { mock('Net::FTP') }

  before do
    ftp.stubs(login: nil, getbinaryfile: nil, close: nil)
    Net::FTP.stubs(:new).returns(ftp)
  end

  describe 'class methods' do
    subject  { FBO::RemoteFile }

    describe 'for_date' do
      it 'should raise an error if no date is given' do
        proc { subject.for_date(nil) }.must_raise ArgumentError
      end

      it 'should return an instance of FBO::RemoteFile' do
        remote_file = subject.for_date(date, tmp_dir: tmp_dir)
        remote_file.must_be_instance_of FBO::RemoteFile
      end
    end
  end

  context 'everything is great' do
    subject  { FBO::RemoteFile.new(filename, tmp_dir: tmp_dir) }

    it 'should attempt to fetch the file via FTP' do
      ftp_session = sequence('ftp_session')
      ftp.expects(:login).in_sequence(ftp_session)
      ftp.expects(:getbinaryfile).with(filename, File.join(tmp_dir, filename)).in_sequence(ftp_session)
      ftp.expects(:close).in_sequence(ftp_session)
      subject
    end

    it 'should to open the file and read its contents' do
      subject.readline.wont_be_nil
    end
  end

  context "temporary directory doesn't exist" do
    subject  { FBO::RemoteFile.new(filename, tmp_dir: 'foo/bar') }

    before do
      Dir.stubs(:exists?).returns(false)
      Dir.stubs(:mkdir)
      File.stubs(:new)
    end

    it 'should create the temporary directory' do
      Dir.expects(:mkdir).with('foo/bar')
      subject
    end
  end
end
