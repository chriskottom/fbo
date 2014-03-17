module FBO
  class Interpreter
    def initialize(file)
      @file = file
      @parser = Parser.new
    end

    # Walk through all notices in the given file.
    # For each notice, yield passing the text block and structure as args.
    #
    def each_notice(&block)
      while true
        string, structure = next_notice(&block)
        break unless string
      end
    end

    # Get the next notice from the file.
    # If a block is given, yield passing the text block and structure as args.
    # Return the text and structure.
    #
    def next_notice(&block)
      return unless notice_text = next_notice_string
      return if notice_text.empty?

      notice_node = parse_notice(notice_text)
      yield notice_text, notice_node if block_given?
      return notice_text, notice_node
    end


    private

    # Get the next whole notice from the FBO dump file.
    # Return an empty string if no more exist
    #
    def next_notice_string
      return if @file.eof?

      line, entry_string = '', ''
      while !@file.eof
        line = @file.gets
        break unless line
        next unless line =~ /\S/
        entry_string += line
        break if line =~ FBO::NOTICE_CLOSE_REGEXP
      end
      return entry_string.strip
    end

    # Parse the text to extract a structure of data for the notice.
    #
    def parse_notice(text)
      tree = @parser.parse(text) 
      tree.elements.first
    end
  end
end
