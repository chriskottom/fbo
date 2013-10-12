require 'forwardable'

module FBO
  class File
    extend Forwardable

    attr_reader     :file
    def_delegators  :@file, :open, :readline, :read, :path, :to_path

    class << self
      def filename_for_date(date)
        raise ArgumentError, "No date given for file" unless date
        "FBOFeed#{ date.strftime("%Y%m%d") }"
      end
    end

    def initialize(filename)
      @file = ::File.new(filename)
    end
  end
end
