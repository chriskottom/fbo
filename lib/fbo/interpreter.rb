module FBO
  class Interpreter
    class << self
      def notice_enumeration(name, type = nil)
        define_method(name) do |&block|
          selected = ( type ? notice_nodes.select { |n| n.is_a? type } : notice_nodes )
          selected.each do |node|
            block.call node.to_hash.merge({ type: node.type })
          end
        end
      end
    end

    notice_enumeration :each_notice, nil
    notice_enumeration :each_presolicitation, FBO::Dump::PresolicitationNode
    notice_enumeration :each_combined_solicitation, FBO::Dump::CombinedSolicitationNode
    notice_enumeration :each_amendment, FBO::Dump::AmendmentNode
    notice_enumeration :each_modification, FBO::Dump::ModificationNode
    notice_enumeration :each_award, FBO::Dump::AwardNode
    notice_enumeration :each_justification_and_approval, FBO::Dump::JustificationAndApprovalNode
    notice_enumeration :each_intent_to_bundle, FBO::Dump::IntentToBundleNode
    notice_enumeration :each_fair_opportunity, FBO::Dump::FairOpportunityNode
    notice_enumeration :each_sources_sought, FBO::Dump::SourcesSoughtNode
    notice_enumeration :each_foreign_standard, FBO::Dump::ForeignStandardNode
    notice_enumeration :each_special_notice, FBO::Dump::SpecialNoticeNode
    notice_enumeration :each_sale_of_surplus, FBO::Dump::SaleOfSurplusNode
    notice_enumeration :each_document_upload, FBO::Dump::DocumentUploadNode
    notice_enumeration :each_document_delete, FBO::Dump::DocumentDeletingNode
    notice_enumeration :each_document_archival, FBO::Dump::DocumentArchivalNode
    notice_enumeration :each_document_unarchival, FBO::Dump::DocumentUnarchivalNode

    def initialize(file)
      @file = file
    end

    private

    def parse
      tree = FBO::Parser.new(@file).parse
      @notice_nodes = tree.elements
    end

    def notice_nodes
      if @notice_nodes.nil?
        parse
      end
      @notice_nodes
    end
  end
end
