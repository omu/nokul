# frozen_string_literal: true

class ProspectiveStudentDecorator < SimpleDelegator
  def calendar
    @calendar ||= unit.calendars.find_by(
      academic_term: academic_term
    )
  end

  def academic_term
    @academic_term ||= AcademicTerm.active.last
  end

  def registration_documents
    @registration_documents ||= unit.registration_documents
                                    .includes(:document)
                                    .where(academic_term: academic_term)
  end

  def permanent_registrable?
    check_events('permanent_registration_applications')
  end

  def temporary_registrable?
    check_events('temporary_registration_applications')
  end

  def document_required?
    registration_documents.present?
  end

  private

  def event_type(identifier)
    CalendarEventType.find_by(identifier: identifier)
  end

  def calendar_events
    calendar.calendar_events
  end

  def check_events(identifier)
    return unless event_type(identifier) && calendar_events.present?

    calendar_events.find_by(
      calendar_event_type: event_type(identifier)
    ).try(:active_now?)
  end
end
