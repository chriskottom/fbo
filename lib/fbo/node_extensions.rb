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
      @@index = 0
      @@start_time = Time.now

      def initialize(input, interval, elements = nil)
        @@index += 1
        super
        puts "#{ @@index.to_s.rjust(4) }  Created new #{ self.class.name } ( #{ Time.now - @@start_time } )"
        @@start_time = Time.now
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

    # Literals for tags within notices
    #
    class DateNode < Treetop::Runtime::SyntaxNode; end
    class YearNode < Treetop::Runtime::SyntaxNode; end
    class AgencyNode < Treetop::Runtime::SyntaxNode; end
    class OfficeNode < Treetop::Runtime::SyntaxNode; end
    class LocationNode < Treetop::Runtime::SyntaxNode; end
    class ZipNode < Treetop::Runtime::SyntaxNode; end
    class ClassificationCodeNode < Treetop::Runtime::SyntaxNode; end
    class NaicsCodeNode < Treetop::Runtime::SyntaxNode; end
    class OfficeAddressNode < Treetop::Runtime::SyntaxNode; end
    class SubjectNode < Treetop::Runtime::SyntaxNode; end
    class SolicitationNumberNode < Treetop::Runtime::SyntaxNode; end
    class NoticeTypeNode < Treetop::Runtime::SyntaxNode; end
    class ResponseDateNode < Treetop::Runtime::SyntaxNode; end
    class ArchiveDateNode < Treetop::Runtime::SyntaxNode; end
    class ContactNode < Treetop::Runtime::SyntaxNode; end
    class DescriptionNode < Treetop::Runtime::SyntaxNode; end
    class LinkNode < Treetop::Runtime::SyntaxNode; end
    class UrlNode < Treetop::Runtime::SyntaxNode; end
    class EmailNode < Treetop::Runtime::SyntaxNode; end
    class EmailAddressNode < Treetop::Runtime::SyntaxNode; end
    class SetAsideNode < Treetop::Runtime::SyntaxNode; end
    class PopAddressNode < Treetop::Runtime::SyntaxNode; end
    class PopZipNode < Treetop::Runtime::SyntaxNode; end
    class PopCountryNode < Treetop::Runtime::SyntaxNode; end
    class AwardNumberNode < Treetop::Runtime::SyntaxNode; end
    class AwardAmountNode < Treetop::Runtime::SyntaxNode; end
    class LineNumberNode < Treetop::Runtime::SyntaxNode; end
    class AwardDateNode < Treetop::Runtime::SyntaxNode; end
    class AwardeeNode < Treetop::Runtime::SyntaxNode; end
    class AwardeeDunsNode < Treetop::Runtime::SyntaxNode; end
    class CorrectionNode < Treetop::Runtime::SyntaxNode; end
    class FileListNode < Treetop::Runtime::SyntaxNode; end
    class FileNode < Treetop::Runtime::SyntaxNode; end
    class MimeTypeNode < Treetop::Runtime::SyntaxNode; end
    class StatutoryAuthorityNode < Treetop::Runtime::SyntaxNode; end
    class ModificationNumberNode < Treetop::Runtime::SyntaxNode; end
    class DeliveryOrderNumberNode < Treetop::Runtime::SyntaxNode; end
    class JustificationAuthorityNode < Treetop::Runtime::SyntaxNode; end
    class CBACNode < Treetop::Runtime::SyntaxNode; end
    class PasswordNode < Treetop::Runtime::SyntaxNode; end
    class ProjectIDNode < Treetop::Runtime::SyntaxNode; end
    class UploadTypeNode < Treetop::Runtime::SyntaxNode; end
    class CorrectionNode < Treetop::Runtime::SyntaxNode; end
  end
end
