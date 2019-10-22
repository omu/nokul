# frozen_string_literal: true

class CurriculumDecorator < SimpleDelegator
  def openable_courses_for_active_term(appends: nil)
    term = AcademicTerm.active.last.try(:term)

    return [] unless term

    openable_courses = semesters.where(term: term)
                                .joins(curriculum_courses: :course)
                                .where.not(curriculum_courses: { id: available_courses.pluck(:curriculum_course_id) })
                                .select('curriculum_courses.id, courses.name')
                                .order('name')

    [*appends, openable_courses].flatten
  end
end
