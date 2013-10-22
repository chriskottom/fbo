require 'treetop'
require 'fbo/node_extensions'

base_path = ::File.expand_path(::File.dirname(__FILE__))
Treetop.load(::File.join(base_path, './dump.treetop'))

module FBO
  class Parser
    def initialize(file)
      @file = file
    end

    def parse(data = nil)
      data ||= @file.contents

      if data.respond_to? :each
        @tree = parse_collection(data)
      else
        @tree = parse_string(data)
      end
      @tree
    end

    private

    def parser
      @parser ||= FBO::DumpParser.new
    end

    def parse_string(data)
      tree = parser.parse(data)
      if tree.nil?
        line = parser.failure_line
        column = parser.failure_column
        reason = parser.failure_reason
        raise Exception, "Parse error at line #{ line }, column #{ column }: #{ reason }"
      end
      clean_tree(tree)
    end

    def parse_collection(data)
      super_tree = nil
      data.each do |string|
        tree = parse_string(string)
        if super_tree
          super_tree = FBO::Dump::DumpNode.new(super_tree.input, super_tree.interval,
                                               super_tree.elements + tree.elements)
        else
          super_tree = tree
        end
      end
      super_tree
    end
    
    def clean_tree(node)
      return if node.elements.nil?
      node.elements.delete_if { |node| node.class.name == "Treetop::Runtime::SyntaxNode" }
      node.elements.each { |node| clean_tree(node) }
      node
    end
  end
end
