require 'forwardable'

module FBO
  class SegmentedFile < File
    extend Forwardable

    attr_reader     :file
    def_delegators  :@file, :eof?, :eof


    def initialize(file)
      @file = file
    end

    FBO::NOTICE_TYPES.each do |type|
      # Define RegExp constants for partitioning the file
      regexp_constant_name = "#{ type.upcase }_REGEXP"
      regexp               = /<#{ type.upcase }>.*<\/#{ type.upcase }>/m
      FBO::SegmentedFile.const_set(regexp_constant_name, regexp)

      # Define methods for accessing content segments
      method_name   = "#{ type }_contents"
      variable_name = "@#{ type }_contents"
      define_method(method_name) do
        if !instance_variable_defined?(variable_name)
          regexp = FBO::SegmentedFile.const_get(regexp_constant_name)
          match_data = @file.contents.match(regexp)
          matched_text = cleanup_data( match_data ? match_data.to_s : nil)
          instance_variable_set(variable_name, matched_text)
        end
        instance_variable_get(variable_name)
      end
    end

    def contents
      @contents ||= [
        presol_contents,
        combine_contents,
        amdcss_contents,
        mod_contents,
        award_contents,
        ja_contents,
        itb_contents,
        fairopp_contents,
        srcsgt_contents,
        fstd_contents,
        snote_contents,
        ssale_contents,
        epsupload_contents,
        delete_contents,
        archive_contents,
        unarchive_contents ].compact
    end

    def contents_for_type(type)
      return unless type
      method_name = "#{ type }_contents"
      self.respond_to?(method_name) ? self.send(method_name) : nil
    end

    private

    def cleanup_data(data)
      return if data.nil?
      data.encode('UTF-16le', :invalid => :replace, :replace => '')
          .encode('UTF-8')
          .gsub(/\r\n/, "\n")
          .gsub(/^M/, "")
    end
  end
end
