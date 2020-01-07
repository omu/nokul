# frozen_string_literal: true

class StudentCourseEnrollmentService # rubocop:disable Metrics/ClassLength
  ECTS = 30

  CompulsoryCourseGroup = OpenStruct.new(name: 'compulsories', completed: false)
  EnrollableError       = Class.new(StandardError)

  attr_reader :student, :catalog

  def initialize(student)
    @student           = student
    @catalog           = Hash.new { |hash, key| hash[key] = {} }
    @available_courses = {}
  end

  def build_catalog
    curriculum_semesters.each do |semester|
      build_semester_catalog(semester)
      break unless completed?(semester)
    end
  end

  def active_term
    AcademicTerm.current
  end

  def selected_ects
    @selected_ects ||= course_enrollments.sum(:ects).to_i
  end

  def remaining_ects
    @remaining_ects ||= ECTS + extra_ects - selected_ects
  end

  def course_enrollments
    @course_enrollments ||=
      student.course_enrollments
             .where(semester: @student.semester)
             .includes(available_course: [curriculum_course: %i[course curriculum_semester]])
  end

  def enrollment_status
    @enrollment_status ||=
      if course_enrollments.any?
        course_enrollments.exists?(status: :draft) ? :draft : :saved
      end
  end

  def enrollable(available_course)
    check_group(available_course) if available_course.type == 'elective'
    check_ects(available_course)
    check_quota(available_course)
    available_course
  end

  def enrollable!(available_course)
    return true if enrollable(available_course).errors.empty?

    raise EnrollableError, available_course.errors.full_messages.first
  end

  def dropable(available_course)
    sequence = available_course.curriculum_course.curriculum_semester.sequence
    available_course.errors.add(:base, translate('must_drop_first')) if max_sequence > sequence

    available_course
  end

  def dropable!(available_course)
    return true if dropable(available_course).errors.empty?

    raise EnrollableError, available_course.errors.full_messages.first
  end

  private

  def extra_ects
    case @student.gpa
    when 1.8..2.49 then 6
    when 2.5..2.99 then 10
    when 3.0..3.49 then 12
    when 3.5..4 then 15
    else 0
    end
  end

  def curriculum
    @curriculum ||= @student.curriculums.active.last
  end

  def curriculum_semesters
    return [] if curriculum.nil?

    @curriculum_semesters ||=
      curriculum.semesters.where(term: active_term.term)
                .where('sequence >= ?', @student.semester)
                .ordered
  end

  def available_courses(semester)
    @available_courses[semester] ||=
      semester.available_courses
              .includes(curriculum_course: %i[course curriculum_course_group])
              .without_ids(course_enrollments.map(&:available_course_id))
  end

  def build_semester_catalog(semester)
    available_courses(semester).each_with_object(@catalog[semester]) do |available_course, collection|
      group      = available_course.curriculum_course_group
      collection = init(collection, group)
      collection << enrollable(available_course)
    end
  end

  def init(collection, group)
    group ||= CompulsoryCourseGroup
    collection[group] = [] unless collection.key?(group)
    collection[group]
  end

  def remaining_ects_for(group)
    group.ects - course_enrollments.where(
      curriculum_courses: { curriculum_course_group_id: group.id }
    ).sum(:ects)
  end

  def max_sequence
    @max_sequence ||= course_enrollments.maximum(:sequence)
  end

  def check_ects(available_course, ects: remaining_ects)
    available_course.errors.add(:base, translate('not_enough_ects')) if ects < available_course.ects
  end

  def check_quota(available_course)
    available_course.errors.add(:base, translate('quota_full')) if available_course.quota_full?
  end

  def check_group(available_course)
    group_remaining_ects = remaining_ects_for(available_course.curriculum_course.curriculum_course_group)
    available_course.errors.add(:base, translate('already_enrolled_at_group')) if group_remaining_ects.zero?
    check_ects(available_course, ects: group_remaining_ects)
  end

  def completed?(semester)
    return false if available_courses(semester).compulsories.present?

    semester.curriculum_course_groups.all? { |group| group_completed?(group) }
  end

  def group_completed?(group)
    group.ects >= course_enrollments.where(available_course_id: group.available_courses.ids).sum(:ects)
  end

  def translate(key, params = {})
    I18n.t("studentship.course_enrollments.errors.#{key}", **params)
  end
end
