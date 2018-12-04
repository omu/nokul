# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class AvailableCoursesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @available_course = available_courses(:ati_fall_2017_2018)
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
      assert_difference('AvailableCourse.count') do
        post available_courses_path, params: {
          available_course: {
            academic_term_id: academic_terms(:fall_2017_2018).id,
            curriculum_id: curriculums(:one).id, course_id: courses(:ydi).id,
            unit_id: units(:omu).id
          }
        }
      end

      available_course = AvailableCourse.last

      assert_equal academic_terms(:fall_2017_2018), available_course.academic_term
      assert_equal curriculums(:one), available_course.curriculum
      assert_equal courses(:ydi), available_course.course
      assert_equal units(:omu), available_course.unit
      assert_redirected_to edit_available_course_available_course_group_path(available_course,
                                                                             available_course.groups.first)
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
          academic_term_id: academic_terms(:fall_2017_2018).id,
          curriculum_id: curriculums(:one).id, course_id: courses(:ydi).id
        }
      }

      available_course.reload

      assert_equal academic_terms(:fall_2017_2018), available_course.academic_term
      assert_equal curriculums(:one), available_course.curriculum
      assert_equal courses(:ydi), available_course.course
      assert_redirected_to available_courses_path
      assert_equal translate('.update.success'), flash[:info]
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
      t("course_management.available_courses#{key}")
    end
  end
end
