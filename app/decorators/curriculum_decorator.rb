# frozen_string_literal: true

class CurriculumDecorator < SimpleDelegator
  def openable_courses_for_active_term(appends: nil)
    term = AcademicTerm.active.last.try(:term)

    return [] unless term

    courses = semesters.where(term: term)
                       .includes(:courses)
                       .where.not(courses: { id: available_courses.pluck(:course_id) })
                       .order('courses.name')
                       .map(&:courses)
    [*appends, courses].flatten
  end
end
