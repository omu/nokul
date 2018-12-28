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
    calendar_events.find_by(calendar_event_type: event_type).try(:active_now?) if event_type && calendar_events.present?
  end

  def temporary_registrable?
    calendar_events.find_by(calendar_event_type: event_type).try(:active_now?) if event_type && calendar_events.present?
  end

  def document_required?
    registration_documents.present?
  end

  private

  def event_type
    CalendarEventType.find_by(identifier: 'temporary_registration')
  end

  def calendar_events
    calendar.calendar_events
  end
end
