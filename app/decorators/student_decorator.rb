# frozen_string_literal: true

class StudentDecorator < SimpleDelegator
  def active_term
    @active_term ||= AcademicTerm.active.last
  end

  def registrable_for_online_course?
    calendar&.check_events('online_course_registrations')
  end

  def registation_date_range
    translate('index.registration_date_range', calendar&.date_range('online_course_registrations'))
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

      course_catalog << { semester: curriculum_semester, courses: selectable_courses_for(curriculum_semester) }

      return course_catalog unless !selectable_ects.negative? && enrolled_in_required_courses_of?(curriculum_semester)
    end
  end

  private

  def calendar
    calendars.last
  end

  def curriculum
    curriculums.active.last
  end

  def curriculum_semesters
    (semesters = curriculum&.semesters) ? semesters.where(term: active_term.term).order(:sequence) : []
  end

  def selectable_courses_for(curriculum_semester)
    CurriculumSemesterDecorator.new(curriculum_semester)
                               .active_available_courses(except: semester_enrollments.pluck(:available_course_id))
                               .flatten
  end

  def enrolled_in_required_courses_of?(curriculum_semester)
    enrolled_course_ids = semester_enrollments.pluck(:available_course_id)
    enrolled = true

    CurriculumSemesterDecorator.new(curriculum_semester).active_available_courses.collect(&:ids).each do |ids|
      break unless enrolled &&= (enrolled_course_ids & ids).any?
    end

    enrolled
  end

  def translate(key, params = {})
    I18n.t("studentship.course_enrollments.#{key}", params)
  end
end
