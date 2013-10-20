module FBO
  class Interpreter
    def initialize(tree)
      @notice_nodes = tree.elements
    end

    def each_notice
      each_node(@notice_nodes, &Proc.new)
    end

    def each_presolicitation
      each_node(nodes_by_type(FBO::Dump::PresolicitationNode), &Proc.new)
    end

    def each_combined_solicitation
      each_node(nodes_by_type(FBO::Dump::CombinedSolicitationNode), &Proc.new)
    end

    def each_amendment
      each_node(nodes_by_type(FBO::Dump::AmendmentNode), &Proc.new)
    end

    def each_modification
      each_node(nodes_by_type(FBO::Dump::ModificationNode), &Proc.new)
    end

    def each_award
      each_node(nodes_by_type(FBO::Dump::AwardNode), &Proc.new)
    end

    def each_justification_and_approval
      each_node(nodes_by_type(FBO::Dump::JustificationAndApprovalNode), &Proc.new)
    end

    def each_intent_to_bundle
      each_node(nodes_by_type(FBO::Dump::IntentToBundleNode), &Proc.new)
    end

    def each_fair_opportunity
      each_node(nodes_by_type(FBO::Dump::FairOpportunityNode), &Proc.new)
    end

    def each_sources_sought
      each_node(nodes_by_type(FBO::Dump::SourcesSoughtNode), &Proc.new)
    end

    def each_foreign_standard
      each_node(nodes_by_type(FBO::Dump::ForeignStandardNode), &Proc.new)
    end

    def each_special_notice
      each_node(nodes_by_type(FBO::Dump::SpecialNoticeNode), &Proc.new)
    end

    def each_sale_of_surplus
      each_node(nodes_by_type(FBO::Dump::SaleOfSurplusNode), &Proc.new)
    end

    def each_document_upload
      each_node(nodes_by_type(FBO::Dump::DocumentUploadNode), &Proc.new)
    end

    def each_document_delete
      each_node(nodes_by_type(FBO::Dump::DocumentDeletingNode), &Proc.new)
    end

    def each_document_archival
      each_node(nodes_by_type(FBO::Dump::DocumentArchivalNode), &Proc.new)
    end

    def each_document_unarchival
      each_node(nodes_by_type(FBO::Dump::DocumentUnarchivalNode), &Proc.new)
    end

    private

    def nodes_by_type(type)
      @notice_nodes.select { |n| n.is_a? type }
    end

    def each_node(nodes)
      nodes.each do |node|
        yield node.to_hash
      end
    end
  end
end
