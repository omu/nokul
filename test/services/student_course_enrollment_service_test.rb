# frozen_string_literal: true

require 'test_helper'

class StudentCourseEnrollmentServiceTest < ActiveSupport::TestCase
  ECTS = 30

  setup do
    @service = StudentCourseEnrollmentService.new(students(:serhat))
  end

  test 'selected_ects method' do
    assert_equal @service.selected_ects, selected_ects
  end

  test 'semester_enrollments method' do
    course_enrollments = @service.semester_enrollments
    assert_not_includes course_enrollments, course_enrollments(:old)
    assert_includes course_enrollments, course_enrollments(:elective)
  end

  test 'enrollment_status method' do
    assert_not StudentCourseEnrollmentService.new(students(:serhat_omu)).enrollment_status
    assert_equal StudentCourseEnrollmentService.new(students(:john)).enrollment_status, :saved
    assert_equal @service.enrollment_status, :draft
  end

  test 'course_catalog method' do
    compulsory_courses = @service.course_catalog.first[:compulsory_courses]
    assert_includes compulsory_courses, available_courses(:compulsory_course_2)
    elective_courses = @service.course_catalog.first[:elective_courses].first[:courses]
    assert_includes elective_courses, available_courses(:elective_course_2)
  end

  private

  def selected_ects
    %i[elective compulsory].inject(0) { |ects, enrollment| ects + course_enrollments(enrollment).ects.to_i }
  end
end
