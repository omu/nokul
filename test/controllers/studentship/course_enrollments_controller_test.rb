# frozen_string_literal: true

require 'test_helper'

module Studentship
  class CourseEnrollmentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
    end

    test 'should get index' do
      get course_enrollments_path
      assert_response :success
    end

    test 'should get new' do
      get new_course_enrollment_path, params: { student_id: students(:serhat).id }
      assert_response :success
    end
  end
end
