# frozen_string_literal: true

require 'test_helper'

class StudentCourseEnrollmentServiceTest < ActiveSupport::TestCase
  setup do
    @service = StudentCourseEnrollmentService.new(students(:serhat))
  end

  test 'build_catalog method' do
    assert_empty @service.catalog
    @service.build_catalog
    assert_not_empty @service.catalog
  end

  test 'active_term method' do
    assert_equal @service.active_term, academic_terms(:active_term)
  end

  test 'selected_ects method' do
    assert_equal @service.selected_ects, 4
  end

  test 'remaining_ects method' do
    assert_equal @service.remaining_ects, 32
  end

  test 'course_enrollments method' do
    course_enrollments = @service.course_enrollments
    assert_not_includes course_enrollments, course_enrollments(:old)
    assert_includes course_enrollments, course_enrollments(:elective)
  end

  test 'enrollment_status method' do
    assert_not StudentCourseEnrollmentService.new(students(:serhat_omu)).enrollment_status
    assert_equal StudentCourseEnrollmentService.new(students(:john)).enrollment_status, :saved
    assert_equal @service.enrollment_status, :draft
  end

  test 'catalog method' do
    @service.build_catalog
    semester_courses = @service.catalog[curriculum_semesters(:bilgisayar_muh_mufredati_ucuncu_donem)]
    CompulsoryCourseGroup = OpenStruct.new(name: 'compulsories', completed: false)
    elective_course_group = curriculum_course_groups(:ucuncu_donem_secmeli_grubu)

    assert_includes semester_courses[CompulsoryCourseGroup], available_courses(:compulsory_course_2)
    assert_includes semester_courses[elective_course_group], available_courses(:elective_course_2)
  end

  test 'enrollable method' do
    assert_empty @service.enrollable(available_courses(:compulsory_course_2)).errors
  end

  test 'enrollable method with error messages' do
    available_course = @service.enrollable(available_courses(:elective_course_2))
    assert_equal available_course.errors.full_messages.first, translate('already_enrolled_at_group')
  end

  test 'enrollabe! method' do
    assert @service.enrollable(available_courses(:compulsory_course_2))
  end

  test 'dropable method' do
    assert_empty @service.dropable(available_courses(:elective_course)).errors
  end

  test 'dropable method with error messages' do
    available_course = @service.dropable(available_courses(:old_course))
    assert_equal available_course.errors.full_messages.first, translate('must_drop_first')
  end

  test 'dropable! method' do
    assert @service.dropable(available_courses(:elective_course))
  end

  private

  def translate(key, params = {})
    I18n.t("studentship.course_enrollments.errors.#{key}", params)
  end
end
