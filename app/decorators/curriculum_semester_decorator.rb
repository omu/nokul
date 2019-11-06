# frozen_string_literal: true

class CurriculumSemesterDecorator < SimpleDelegator
  # TODO: Gelistirilecek
  def selectable_courses(appends: [])
    courses = unit.courses.active - curriculum.courses - elective_courses
    merge(courses, appends)
  end

  def selectable_course_groups(appends: [])
    course_groups = unit.course_groups - curriculum.course_groups
    merge(course_groups, appends)
  end

  def build_curriculum_course_groups
    selectable_course_groups.map do |course_group|
      curriculum_course_groups.new(course_group_id: course_group.id)
                              .build_curriculum_courses
    end
  end

  def elective_ids
    curriculum_course_groups.joins(curriculum_courses: :available_courses)
                            .where('available_courses.academic_term_id = ?', active_term)
                            .select('curriculum_course_groups.id, available_courses.id as available_course_id')
                            .group_by(&:id)
                            .collect { |_group_id, group| group.pluck('available_course_id') }
  end

  def compulsory_ids
    curriculum_courses.compulsory.includes(:available_courses)
                      .where('available_courses.academic_term_id = ?', active_term)
                      .pluck('available_courses.id')
  end

  private

  def merge(collection, appends)
    return collection if appends.blank?

    (collection + appends.compact).uniq
  end

  def unit
    @unit ||= curriculum.unit
  end

  def elective_courses
    unit.course_groups.includes(:courses).map(&:courses).flatten
  end

  def active_term
    AcademicTerm.active.last
  end
end
