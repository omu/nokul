# frozen_string_literal: true

class CurriculumSemesterDecorator < SimpleDelegator
  def available_courses(addition: [])
    courses = curriculum.unit.courses.active.where.not(id: curriculum.courses.ids)
    addition(courses, addition)
  end

  def available_course_groups(addition: [])
    course_groups = curriculum.unit.course_groups.where.not(
      id: curriculum.curriculum_course_groups.ids
    )
    addition(course_groups, addition)
  end

  private

  def addition(collection, addition)
    return collection if addition.blank?

    (collection + addition.compact).uniq
  end
end
