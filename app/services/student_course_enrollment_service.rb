# frozen_string_literal: true

class StudentCourseEnrollmentService
  ECTS = 30

  def initialize(student)
    @student = student
  end

  def active_term
    @active_term ||= AcademicTerm.active.last
  end

  def selected_ects
    @selected_ects ||= semester_enrollments.sum(:ects).to_i
  end

  def selectable_ects
    @selectable_ects ||= ECTS + plus_ects - selected_ects
  end

  def semester_enrollments
    @semester_enrollments ||=
      @student.course_enrollments.where(semester: @student.semester)
                                 .includes(available_course: [curriculum_course: %i[course curriculum_semester]])
  end

  def enrollment_status
    @enrollment_status ||=
      if (statuses = semester_enrollments.pluck(:status)).any?
        statuses.include?('draft') ? :draft : :saved
      end
  end

  def course_catalog
    course_catalog = []

    curriculum_semesters.each do |curriculum_semester|
      next if @student.semester > curriculum_semester.sequence
      next if selectable_ects < 1

      course_catalog << { semester:           curriculum_semester,
                          compulsory_courses: compulsory_courses_for(curriculum_semester),
                          elective_courses:   elective_courses_for(curriculum_semester) }

      break unless enrolled_in_required_courses_of?(curriculum_semester)
    end

    course_catalog
  end

  def ensure_dropable(available_course)
    sequence = available_course.curriculum_course.curriculum_semester.sequence
    available_course.errors.add(:base, translate('must_drop_first')) if max_sequence > sequence

    available_course
  end

  def ensure_addable(available_course)
    available_course.errors.add(:base, translate('not_enough_ects')) if selectable_ects < available_course.ects
    available_course.errors.add(:base, translate('quota_full')) if available_course.quota_full?

    available_course
  end

  def enroll_a_course_from_group?(group)
    semester_enrollments.includes(available_course: :curriculum_course)
                        .where(curriculum_courses: { curriculum_course_group_id: group.id })
                        .sum(:ects)
                        .eql?(group.ects)
  end

  private

  def plus_ects
    case @student.gpa
    when 1.8..2.49 then 6
    when 2.5..2.99 then 10
    when 3.0..3.49 then 12
    when 3.5..4 then 15
    else 0
    end
  end

  def curriculum
    @student.curriculums.active.last
  end

  def curriculum_semesters
    return [] if curriculum.id.nil?

    curriculum.semesters.where(term: active_term.term).order(:sequence)
  end

  def compulsory_courses_for(curriculum_semester)
    curriculum_semester.available_courses
                       .where.not(id: semester_enrollments.pluck(:available_course_id))
                       .where(academic_term_id: active_term.id)
                       .where(curriculum_courses: { type: :compulsory })
                       .each { |available_course| ensure_addable(available_course) }
  end

  def elective_courses_for(curriculum_semester)
    curriculum_semester.curriculum_course_groups.each_with_object([]) do |group, group_courses|
      courses = group.available_courses
                     .where.not(id: semester_enrollments.pluck(:available_course_id))
                     .where(academic_term_id: active_term.id)
                     .each { |available_course| ensure_addable(available_course) }

      group_courses << { group: group, courses: courses }
    end
  end

  def enrolled_in_required_courses_of?(curriculum_semester)
    enrolled_in_compulsory_courses?(curriculum_semester) &&
      enrolled_in_elective_courses?(curriculum_semester)
  end

  def enrolled_in_compulsory_courses?(curriculum_semester)
    curriculum_semester.available_courses
                       .where.not(id: semester_enrollments.pluck(:available_course_id))
                       .where(curriculum_courses: { type: :compulsory })
                       .where(academic_term_id: active_term.id)
                       .empty?
  end

  def enrolled_in_elective_courses?(curriculum_semester)
    curriculum_semester.curriculum_course_groups.inject(true) do |enrolled, group|
      break unless enrolled &&= !enroll_a_course_from_group?(group)

      enrolled
    end
  end

  def max_sequence
    @max_sequence ||= semester_enrollments.pluck(:sequence).max
  end

  def translate(key, params = {})
    I18n.t("studentship.course_enrollments.#{key}", params)
  end
end
  
