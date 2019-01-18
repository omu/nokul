# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class AvailableCoursesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @available_course = available_courses(:ati_fall_2018_2019)
    end

    test 'should get index' do
      get available_courses_path
      assert_response :success
    end

    test 'should get show' do
      get available_course_path(@available_course)
      assert_response :success
    end

    test 'should get new' do
      get new_available_course_path
      assert_response :success
    end

    test 'should create available course' do
      parameters = {
        academic_term: academic_terms(:fall_2018_2019),
        curriculum_id: curriculums(:one).id,
        course_id: courses(:ydi).id,
        coordinator_id: employees(:chief_john).id,
        unit_id: units(:omu).id
      }

      assert_difference('AvailableCourse.count') do
        post available_courses_path, params: { available_course: parameters }
      end

      available_course = AvailableCourse.last

      parameters.each do |attribute, value|
        assert_equal value, available_course.send(attribute)
      end
      assert_redirected_to new_available_course_available_course_group_path(available_course)
    end

    test 'should get edit' do
      get edit_available_course_path(@available_course)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update available course' do
      available_course = AvailableCourse.last
      patch available_course_path(available_course), params: {
        available_course: {
          curriculum_id: curriculums(:one).id, course_id: courses(:ydi).id
        }
      }

      available_course.reload

      assert_equal curriculums(:one), available_course.curriculum
      assert_equal courses(:ydi), available_course.course
      assert_redirected_to available_course_path(available_course)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy available course' do
      assert_difference('AvailableCourse.count', -1) do
        delete available_course_path(AvailableCourse.last)
      end

      assert_redirected_to available_courses_path
      assert_equal translate('.destroy.success'), flash[:info]
    end

    private

    def translate(key)
      t("course_management.available_courses#{key}", course: @available_course.name)
    end
  end
end
