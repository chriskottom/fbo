module FBO
  class Interpreter
    class << self
      def notice_enumeration(name, type)
        define_method(name) do |&block|
          selected = notice_nodes(type)
          return unless selected
          selected.each do |node|
            block.call node.to_hash.merge({ type: node.type })
          end
        end
      end
    end

    notice_enumeration :each_notice, :all
    notice_enumeration :each_presolicitation, :presol
    notice_enumeration :each_combined_solicitation, :combine
    notice_enumeration :each_amendment, :amdcss
    notice_enumeration :each_modification, :mod
    notice_enumeration :each_award, :award
    notice_enumeration :each_justification_and_approval, :ja
    notice_enumeration :each_intent_to_bundle, :itb
    notice_enumeration :each_fair_opportunity, :fairopp
    notice_enumeration :each_sources_sought, :srcsgt
    notice_enumeration :each_foreign_standard, :fstd
    notice_enumeration :each_special_notice, :snote
    notice_enumeration :each_sale_of_surplus, :ssale
    notice_enumeration :each_document_upload, :epsupload
    notice_enumeration :each_document_delete, :delete
    notice_enumeration :each_document_archival, :archive
    notice_enumeration :each_document_unarchival, :unarchive

    def initialize(file)
      @file = file
    end

    private

    def notice_nodes(type = :all)
      if @notice_nodes.nil?
        @notice_nodes = {}
      end

      if @file.is_a?(FBO::SegmentedFile) && type != :all
        @notice_nodes[type] = parse_segment(type)
      else
        @notice_nodes[:all] = parse_file
        if type == :all
          @notice_nodes[:all]
        else
          @notice_nodes[type] = @notice_nodes[:all].select { |n| n.type == type }
        end
      end
    end

    def parse_file
      tree = FBO::Parser.new(@file).parse
      tree.elements
    end

    def parse_segment(type = :all)
      return unless @file.is_a? FBO::SegmentedFile

      content = ""
      if type == :all
        content = @file.contents
      else
        content = @file.contents_for_type(type)
      end
      return unless content

      tree = FBO::Parser.new.parse(content)
      tree.elements
    end
  end
end
