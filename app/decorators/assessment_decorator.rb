# frozen_string_literal: true

class AssessmentDecorator < SimpleDelegator
  def results_announcement_active?
    event_results_announcement.try(:active_now?)
  end

  def date_range
    translate(
      'index.results_announcement_date_range',
      start_time: event_results_announcement&.start_time&.strftime('%F %R'),
      end_time:   event_results_announcement&.end_time&.strftime('%F %R')
    )
  end

  def editable?
    !saved? && saved_enrollments.any?
  end

  def saveable?
    draft? && fully_graded?
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

  def event_results_announcement
    calendar&.event(identifier)
  end

  def translate(key, params = {})
    I18n.t("instructiveness.assessments.#{key}", **params)
  end
end
