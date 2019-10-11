# frozen_string_literal: true

class ProspectiveStudentDecorator < SimpleDelegator
  def calendar
    @calendar ||= unit.calendars.find_by(
      academic_term: academic_term
    )
  end

  def registration_documents
    @registration_documents ||= unit.registration_documents
                                    .includes(:document_type)
                                    .where(academic_term: academic_term)
  end

  def permanent_registrable?
    calendar.check_events('permanent_registration_applications')
  end

  def temporary_registrable?
    calendar.check_events('temporary_registration_applications')
  end

  def document_required?
    registration_documents.present?
  end
end
