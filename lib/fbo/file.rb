require 'forwardable'

module FBO
  class File
    extend Forwardable

    attr_reader     :file
    def_delegators  :@file, :open, :readline, :read, :path, :to_path, :eof?

    class << self
      def filename_for_date(date)
        raise ArgumentError, "No date given for file" unless date
        "FBOFeed#{ date.strftime("%Y%m%d") }"
      end
    end

    def initialize(filename)
      @file = ::File.new(filename)
    end

    def contents
      if @contents.nil?
        @contents = cleanup_data(@file.read)
      end
      @contents
    end

    private


    def cleanup_data(data)
      data.encode('UTF-16le', :invalid => :replace, :replace => '')
          .encode('UTF-8')
          .gsub(/\r\n/, "\n")
          .gsub(/^M/, "")
    end
  end
end
