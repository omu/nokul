# frozen_string_literal: true

class ProspectiveStudentDecorator < SimpleDelegator
  def academic_calendar
    @academic_calendar ||= unit.academic_calendars.find_by(
      academic_term: academic_term
    )
  end

  def academic_term
    @academic_term ||= AcademicTerm.active.first
  end

  def registration_documents
    @registration_documents ||= unit.registration_documents
                                    .includes(:document)
                                    .where(academic_term: academic_term)
  end

  def permanent_registrable?
    academic_calendar.try(:proper_event_range?, :application_permanent_registration)
  end

  def temporary_registrable?
    academic_calendar.try(:proper_event_range?, :application_temporary_registration)
  end

  def document_required?
    registration_documents.present?
  end
end
