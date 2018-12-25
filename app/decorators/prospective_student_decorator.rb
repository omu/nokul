# frozen_string_literal: true

class ProspectiveStudentDecorator < SimpleDelegator
  def academic_term
    @academic_term ||= AcademicTerm.active.first
  end

  def registration_documents
    @registration_documents ||= unit.registration_documents
                                    .includes(:document)
                                    .where(academic_term: academic_term)
  end

  def document_required?
    registration_documents.present?
  end
end
