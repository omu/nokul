# frozen_string_literal: true

require 'test_helper'

class StudentDecoratorTest < ActiveSupport::TestCase
  setup do
    @student = StudentDecorator.new(students(:serhat))
  end

  test 'registrable_for_online_course? method' do
    assert_not StudentDecorator.new(students(:serhat_omu)).registrable_for_online_course?
    assert StudentDecorator.new(@student).registrable_for_online_course?
  end

  test 'registation_date_range method' do
    calendar = calendars(:bm_calendar)
    assert_equal StudentDecorator.new(@student).registation_date_range,
                 translate('index.registration_date_range', calendar.date_range('online_course_registrations'))
  end

  test 'enrollment_status method' do
    assert_not StudentDecorator.new(students(:serhat_omu)).enrollment_status
    assert_equal StudentDecorator.new(students(:john)).enrollment_status, :saved
    assert_equal @student.enrollment_status, :draft
  end

  test 'course_catalog method' do
    courses = @student.course_catalog.first[:courses]
    assert_includes courses, available_courses(:elective_course_2)
    assert_includes courses, available_courses(:compulsory_course_2)
  end

  private

  def translate(key, params = {})
    t("studentship.course_enrollments.#{key}", params)
  end
end
