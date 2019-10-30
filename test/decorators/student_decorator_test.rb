# frozen_string_literal: true

require 'test_helper'

class StudentDecoratorTest < ActiveSupport::TestCase
  TOTAL_ECTS = 30

  setup do
    @student = StudentDecorator.new(students(:serhat))
  end

  test 'registrable_for_online_course? method' do
    assert_not StudentDecorator.new(students(:serhat_omu)).registrable_for_online_course?
    assert StudentDecorator.new(@student).registrable_for_online_course?
  end

  test 'enrollment_status method' do
    assert_equal @student.enrollment_status, :draft
  end

  test 'semester_enrollments method' do
    course_enrollments = @student.semester_enrollments
    assert_not_includes course_enrollments, course_enrollments(:old)
    assert_includes course_enrollments, course_enrollments(:elective)
  end

  test 'selected_ects method' do
    assert_equal @student.selected_ects, selected_ects
  end

  test 'selectable_ects method' do
    assert_equal @student.selectable_ects, TOTAL_ECTS - selected_ects
  end

  test 'selected_courses method' do
    courses = @student.selected_courses
    assert_not_includes courses, [course_enrollments(:old), false]
    assert_not_includes courses, [course_enrollments(:old), true]
    assert_not_includes courses, [course_enrollments(:elective), false]
    assert_includes courses, [course_enrollments(:elective), true]
  end

  test 'selectable_courses method' do
    courses = @student.selectable_courses.map { |row| row[1] }[0]
    assert_includes courses, [available_courses(:elective_course_2), false, translate('.already_enrolled_at_group')]
    assert_includes courses, [available_courses(:compulsory_course_2), true]
  end

  private

  def selected_ects
    %i[elective compulsory].inject(0) { |ects, enrollment| ects + course_enrollments(enrollment).ects.to_i }
  end

  def translate(key)
    t("studentship.course_enrollments.new#{key}")
  end
end
