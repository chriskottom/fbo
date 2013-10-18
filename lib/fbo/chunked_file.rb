require 'forwardable'

module FBO
  class ChunkedFile
    extend Forwardable

    attr_reader     :file, :chunk_size
    def_delegators  :@file, :readline, :read, :eof?


    DEFAULT_CHUNK_SIZE    = 250 * 1024   # 250KB
    NOTICE_TAG_NAMES      = %w( PRESOL COMBINE AMDCSS MOD AWARD JA ITB FAIROPP FSTD) +
                            %w( SRCSGT SNOTE SSALE EPSUPLOAD DELETE ARCHIVE UNARCHIVE )
    NOTICE_CLOSE_REGEXP   = /<\/(#{ NOTICE_TAG_NAMES.join('|') })>$/


    def initialize(file, chunk_size = DEFAULT_CHUNK_SIZE)
      @file = file
      @chunk_size = chunk_size
    end

    def contents
      if @contents.nil?
        @contents = []
        while !eof?
          @contents << next_chunk
        end
        @contents.compact!
      end
      @contents
    end


    private

    def next_chunk
      return nil if eof?

      chunk, line = "", ""

      # Run up the chunk to about #chunk_size.
      begin
        line = gets
        break unless line
        chunk += line
      end while (chunk.bytesize < @chunk_size)

      # Add lines up to the end of a notice.
      if line && line !~ NOTICE_CLOSE_REGEXP
        begin
          line = gets
          break unless line
          chunk += line
          break if line =~ NOTICE_CLOSE_REGEXP
        end while (true)
      end

      return chunk.strip
    end

    def gets
      line = file.gets
      return unless line
      cleanup_data(line)
    end
 
    def cleanup_data(data)
      data.encode('UTF-16le', :invalid => :replace, :replace => '')
          .encode('UTF-8')
          .gsub(/\r\n/, "\n")
          .gsub(/^M/, "")
    end
  end
end
