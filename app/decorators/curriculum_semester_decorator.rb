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

  def active_available_courses(except: nil)
    curriculum_course_groups.includes(available_courses: [curriculum_course: %i[course curriculum_course_group]])
                            .where.not(available_courses: { id: except })
                            .where(available_courses: { academic_term: active_term })
                            .collect(&:available_courses) +
      curriculum_courses.includes(:available_courses, :course)
                        .where(type: :compulsory, available_courses: { academic_term: active_term })
                        .where.not(available_courses: { id: except })
                        .map(&:available_courses)
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
