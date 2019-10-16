# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class EnrolledCoursesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
    end

    test 'should get index' do
      get index_path, params: { student_id: students(:serhat).id }
      assert_response :success
    end

    private

    def index_path
      enrolled_courses_path
    end
  end
end
