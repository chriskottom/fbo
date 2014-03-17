module FBO
  class ParserError < ::StandardError
    attr_reader  :data, :parent

    def initialize(msg, data: nil, e: nil)
      super(msg)
      @data = data
      @parent = e
      set_backtrace(e.backtrace) if e
    end
  end
end
