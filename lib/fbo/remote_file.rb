require 'date'
require 'net/ftp'

module FBO
  class RemoteFile < File
    FTP_SERVER = 'ftp.fbo.gov'
    TMP_DIR    = '/tmp/fbo'

    class << self
      def for_date(date, options = {})
        filename = filename_for_date(date)
        FBO::RemoteFile.new(filename, options)
      end
    end

    def initialize(filename, options = {})
      @filename = filename
      @tmp_dir = options[:tmp_dir] || TMP_DIR
      @file = fetch_file(filename)
    end

    protected

    def fetch_file(filename)
      Dir.mkdir(@tmp_dir) unless Dir.exists?(@tmp_dir)
      tmp_filename = ::File.join(@tmp_dir, filename)
      ftp = Net::FTP.new(FTP_SERVER)
      ftp.login
      ftp.getbinaryfile(filename, tmp_filename)
      ftp.close
      ::File.new(tmp_filename)
    end
  end
end
