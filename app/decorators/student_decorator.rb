# frozen_string_literal: true

class StudentDecorator < SimpleDelegator
  def active_term
    @active_term ||= AcademicTerm.active.last
  end

  def registrable_for_online_course?
    event_online_course_registrations.try(:active_now?)
  end

  def registation_date_range
    translate(
      'index.registration_date_range',
      start_time: event_online_course_registrations&.start_time&.strftime('%F %R'),
      end_time:   event_online_course_registrations&.end_time&.strftime('%F %R')
    )
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
      next if semester > curriculum_semester.sequence
      next if selectable_ects < 1

      course_catalog << { semester:           curriculum_semester,
                          compulsory_courses: compulsory_courses_for(curriculum_semester),
                          elective_courses:   elective_courses_for(curriculum_semester) }

      break unless enrolled_in_required_courses_of?(curriculum_semester)
    end

    course_catalog
  end

  private

  def calendar
    calendars.last
  end

  def curriculum
    curriculums.active.last
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
      break unless enrolled &&= enroll_a_course_from_group?(group)

      enrolled
    end
  end

  def event_online_course_registrations
    calendar&.event('online_course_registrations')
  end

  def translate(key, params = {})
    I18n.t("studentship.course_enrollments.#{key}", params)
  end
end
