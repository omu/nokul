# frozen_string_literal: true

class CurriculumSemesterDecorator < SimpleDelegator
  # TODO: Gelistirilecek
  def available_courses(appends: [])
    courses = curriculum.unit.courses.active.except_for(curriculum.courses)
    merge(courses, appends)
  end

  def available_course_groups(appends: [])
    course_groups = curriculum.unit.course_groups.except_for(
      curriculum.course_groups
    )
    merge(course_groups, appends)
  end

  private

  def merge(collection, appends)
    return collection if appends.blank?

    (collection + appends.compact).uniq
  end
end
