# frozen_string_literal: true

class AssessmentDecorator < SimpleDelegator
  def editable?
    !saved? && saved_enrollments.any?
  end

  def saveable?
    draft? && fully_graded?
  end

  def results_announcement_event
    @results_announcement_event ||= CalendarEventDecorator.new(calendar&.event(identifier))
  end

  private

  def calendar
    course_evaluation_type.available_course.unit.calendars.last
  end

  def identifier
    case course_evaluation_type.name
    when 'Dönem İçi Değerlendirme'
      'mid_term_results_announcement'
    when 'Dönem Sonu Değerlendirme'
      'final_results_announcement'
    when 'Bütünleme Değerlendirme'
      'retake_results_announcement'
    end
  end
end
