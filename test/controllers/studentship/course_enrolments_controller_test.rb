# frozen_string_literal: true

require 'test_helper'

module Studentship
  class CourseEnrolmentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
    end

    test 'should get index' do
      get index_path, params: { student_id: students(:serhat).id }
      assert_response :success
    end

    private

    def index_path
      course_enrolments_path
    end
  end
end
