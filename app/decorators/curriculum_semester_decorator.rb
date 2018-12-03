# frozen_string_literal: true

class CurriculumSemesterDecorator < SimpleDelegator
  def available_courses(addition: [])
    courses = curriculum.unit.courses.active.except_for(curriculum.courses)
    addition(courses, addition)
  end

  def available_course_groups(addition: [])
    course_groups = curriculum.unit.course_groups.except_for(
      curriculum.curriculum_course_groups
    )
    addition(course_groups, addition)
  end

  private

  def addition(collection, addition)
    return collection if addition.blank?

    (collection + addition.compact).uniq
  end
end
