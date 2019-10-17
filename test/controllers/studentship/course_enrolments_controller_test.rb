# frozen_string_literal: true

require 'test_helper'

module Studentship
  class CourseEnrolmentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
    end

    test 'should get index' do
      get course_enrolments_path
      assert_response :success
    end

    test 'should get new' do
      get new_course_enrolment_path, params: { student_id: students(:serhat).id }
      assert_response :success
    end
  end
end
