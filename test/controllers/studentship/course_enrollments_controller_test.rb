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
          course_enrollment: {
            available_course_id:       available_courses(:compulsory_course_2).id,
            available_course_group_id: available_course_groups(:compulsory_course_2_group).id
          }
        }
      end

      course_enrollment = CourseEnrollment.last

      assert_equal available_courses(:compulsory_course_2), course_enrollment.available_course
      assert_equal 'draft', course_enrollment.status
      assert_redirected_to new_student_course_enrollment_path(@student)
    end

    test 'should save' do
      delete student_course_enrollment_path(@student, course_enrollments(:elective))
      get save_student_course_enrollments_path(@student)
      assert @student.current_registration.saved?
      assert_redirected_to list_student_course_enrollments_path
    end

    test 'should destroy course_enrollment' do
      assert_difference('CourseEnrollment.count', -1) do
        delete student_course_enrollment_path(@student, course_enrollments(:compulsory))
      end

      assert_redirected_to new_student_course_enrollment_path(@student)
    end
  end
end
