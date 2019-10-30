# frozen_string_literal: true

require 'test_helper'

module Studentship
  class CourseEnrollmentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @student = students(:serhat)
    end

    test 'should get index' do
      get course_enrollments_path
      assert_response :success
    end

    test 'should get new' do
      get new_course_enrollment_path, params: { student_id: @student.id }
      assert_response :success
    end

    test 'should create course_enrollment' do
      assert_difference('CourseEnrollment.count') do
        post course_enrollments_path params: {
          available_course_id: available_courses(:compulsory_course_2).id,
          student_id:          @student.id
        }
      end

      course_enrollment = CourseEnrollment.last

      assert_equal available_courses(:compulsory_course_2), course_enrollment.available_course
      assert_equal @student, course_enrollment.student
      assert_equal @student.semester, course_enrollment.semester
      assert_equal 'draft', course_enrollment.status
      assert_redirected_to new_course_enrollment_path
    end

    test 'should save' do
      get save_course_enrollments_path, params: { student_id: @student.id }
      assert_equal StudentDecorator.new(@student).enrollment_status, :saved
      assert_redirected_to new_course_enrollment_path
    end

    test 'should destroy course_enrollment' do
      assert_difference('CourseEnrollment.count', -1) do
        delete course_enrollment_path(CourseEnrollment.last, student_id: @student.id)
      end

      assert_redirected_to new_course_enrollment_path
    end
  end
end
