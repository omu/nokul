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
    CalendarEventDecorator.new(calendar&.event('permanent_registration_applications')).active_now?
  end

  def temporary_registrable?
    CalendarEventDecorator.new(calendar&.event('temporary_registration_applications')).active_now?
  end

  def document_required?
    registration_documents.present?
  end
end
