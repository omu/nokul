# frozen_string_literal: true

require 'test_helper'

module Instructiveness
  class GivenCoursesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @course = available_courses(:compulsory_course)
    end

    test 'should get index' do
      get given_courses_path
      assert_equal 'index', @controller.action_name
      assert_response :success
    end

    test 'should get show' do
      get given_course_path(@course)
      assert_equal 'show', @controller.action_name
      assert_response :success
    end

    test 'should get students' do
      get students_given_course_path(@course)
      assert_equal 'students', @controller.action_name
      assert_response :success
    end
  end
end
