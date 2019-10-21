# frozen_string_literal: true

class StudentDecorator < SimpleDelegator
  TOTAL_ECTS = 30

  def active_term
    @active_term ||= AcademicTerm.active.last
  end

  def calendar
    calendars.last
  end

  def registrable_for_online_course?
    calendar&.check_events('online_course_registrations')
  end

  def selected_ects
    selected_courses.sum(&:ects).to_i
  end

  def selectable_ects
    TOTAL_ECTS - selected_ects
  end

  def selectable_courses
    semesters = curriculum.semesters.where(term: active_term.term).order(:sequence)
    semesters.collect { |semester| [semester, available_courses_for_semester(semester)] }
  end

  def selected_courses
    course_enrollments.includes(available_course: [curriculum_course: :course])
                      .where(semester: semester)
  end

  private

  def curriculum
    curriculums.active.last
  end

  # TODO: fix for selected elective courses
  def available_courses_for_semester(curriculum_semester)
    curriculum_semester.available_courses.includes(curriculum_course: :course)
                       .where(academic_term: active_term)
                       .where.not(id: selected_courses.pluck(:available_course_id))
                       .order('courses.name')
  end
end
