# frozen_string_literal: true

class StudentDecorator < SimpleDelegator
  def calendar
    calendars.last
  end

  def registrable_for_online_course?
    calendar&.check_events('online_course_registrations')
  end

  def course_catalog
    semesters = curriculum.semesters.where(term: active_term.term).order(:sequence)
    semesters.collect { |semester| [semester, available_courses_for_semester(semester)] }
  end

  # TODO
  def enrolled_courses
    course_enrollments.includes(:available_course)
                      .where(year: 1, sequence: 1)
  end

  private

  def active_term
    AcademicTerm.active.last
  end

  def curriculum
    curriculums.active.last
  end

  def available_courses_for_semester(semester)
    semester.available_courses.includes(curriculum_course: :course)
                              .where(academic_term: active_term)
                              .where.not(id: enrolled_courses.pluck(:available_course_id))
                              .order('courses.name')
  end
end
