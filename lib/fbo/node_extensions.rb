module FBO
  module Dump

    # Structural node types
    #
    class DumpNode < Treetop::Runtime::SyntaxNode; end
    class BodyNode < Treetop::Runtime::SyntaxNode; end
    class TagContentNode < Treetop::Runtime::SyntaxNode; end

    # Node types corresponding to 
    #
    class NoticeNode < Treetop::Runtime::SyntaxNode
      def to_hash
        body_node = elements.first
        Hash[ body_node.elements.map { |e| [ e.to_sym, e.value ] } ]
      end
    end
    class PresolicitationNode < NoticeNode; end
    class CombinedSolicitationNode < NoticeNode; end
    class AmendmentNode < NoticeNode; end
    class ModificationNode < NoticeNode; end
    class AwardNode < NoticeNode; end
    class JustificationAndApprovalNode < NoticeNode; end
    class IntentToBundleNode < NoticeNode; end
    class FairOpportunityNode < NoticeNode; end
    class SourcesSoughtNode < NoticeNode; end
    class ForeignStandardNode < NoticeNode; end
    class SpecialNoticeNode < NoticeNode; end
    class SaleOfSurplusNode < NoticeNode; end
    class DocumentUploadNode < NoticeNode; end
    class DocumentDeletingNode < NoticeNode; end
    class DocumentArchivalNode < NoticeNode; end
    class DocumentUnarchivalNode < NoticeNode; end

    # Simple property nodes have a name/symbol and a value
    #
    class SimplePropertyNode < Treetop::Runtime::SyntaxNode
      def to_sym
        class_name = self.class.name
        base_name = class_name.split('::').last
        base_name.sub!(/Node$/, '')
        base_name.gsub!(/([^A-Z])([A-Z])/, '\1_\2')
        base_name.tr!('A-Z', 'a-z')
        base_name.to_sym
      end

      def value
        elements[0].text_value
      end

      def to_hash
        { self.to_sym => self.value }
      end
    end
    class DateNode < SimplePropertyNode; end
    class YearNode < SimplePropertyNode; end
    class AgencyNode < SimplePropertyNode; end
    class OfficeNode < SimplePropertyNode; end
    class LocationNode < SimplePropertyNode; end
    class ZipNode < SimplePropertyNode; end
    class ClassificationCodeNode < SimplePropertyNode; end
    class NaicsCodeNode < SimplePropertyNode; end
    class OfficeAddressNode < SimplePropertyNode; end
    class SubjectNode < SimplePropertyNode; end
    class SolicitationNumberNode < SimplePropertyNode; end
    class NoticeTypeNode < SimplePropertyNode; end
    class ResponseDateNode < SimplePropertyNode; end
    class ArchiveDateNode < SimplePropertyNode; end
    class ContactNode < SimplePropertyNode; end
    class DescriptionNode < SimplePropertyNode; end
    class UrlNode < SimplePropertyNode; end
    class EmailAddressNode < SimplePropertyNode; end
    class SetAsideNode < SimplePropertyNode; end
    class PopAddressNode < SimplePropertyNode; end
    class PopZipNode < SimplePropertyNode; end
    class PopCountryNode < SimplePropertyNode; end
    class AwardNumberNode < SimplePropertyNode; end
    class AwardAmountNode < SimplePropertyNode; end
    class LineNumberNode < SimplePropertyNode; end
    class AwardDateNode < SimplePropertyNode; end
    class AwardeeNode < SimplePropertyNode; end
    class AwardeeDunsNode < SimplePropertyNode; end
    class CorrectionNode < SimplePropertyNode; end
    class FileNode < SimplePropertyNode; end
    class MimeTypeNode < SimplePropertyNode; end
    class StatutoryAuthorityNode < SimplePropertyNode; end
    class ModificationNumberNode < SimplePropertyNode; end
    class DeliveryOrderNumberNode < SimplePropertyNode; end
    class JustificationAuthorityNode < SimplePropertyNode; end
    class CBACNode < SimplePropertyNode; end
    class PasswordNode < SimplePropertyNode; end
    class ProjectIDNode < SimplePropertyNode; end
    class UploadTypeNode < SimplePropertyNode; end
    class CorrectionNode < SimplePropertyNode; end

    # Complex properties may contain other simple properties
    #
    class ComplexPropertyNode < SimplePropertyNode
      def value
        value_hash = {}
        elements.each { |e| value_hash.merge!(e.to_hash) }
        value_hash
      end
    end
    class LinkNode < ComplexPropertyNode; end
    class EmailNode < ComplexPropertyNode; end
    class FileListNode < ComplexPropertyNode; end
  end
end
