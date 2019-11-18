# frozen_string_literal: true

require 'test_helper'

module Studentship
  class CourseEnrollmentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @student = students(:serhat)
    end

    test 'should get index' do
      get student_course_enrollments_path(@student)
      assert_response :success
    end

    test 'should get new' do
      get new_student_course_enrollment_path(@student)
      assert_response :success
    end

    test 'should create course_enrollment' do
      assert_difference('CourseEnrollment.count') do
        post student_course_enrollments_path(@student), params: {
          course_enrollment: { available_course_id: available_courses(:compulsory_course_2).id }
        }
      end

      course_enrollment = CourseEnrollment.last

      assert_equal available_courses(:compulsory_course_2), course_enrollment.available_course
      assert_equal @student, course_enrollment.student
      assert_equal @student.semester, course_enrollment.semester
      assert_equal 'draft', course_enrollment.status
      assert_redirected_to new_student_course_enrollment_path(@student)
    end

    test 'should save' do
      get save_student_course_enrollments_path(@student)
      assert_equal StudentDecorator.new(@student).enrollment_status, :saved
      assert_redirected_to list_student_course_enrollments_path
    end

    test 'should destroy course_enrollment' do
      assert_difference('CourseEnrollment.count', -1) do
        delete student_course_enrollment_path(@student, CourseEnrollment.last)
      end

      assert_redirected_to new_student_course_enrollment_path(@student)
    end
  end
end
