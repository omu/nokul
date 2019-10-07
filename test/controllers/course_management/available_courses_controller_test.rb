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
      assert_difference('AvailableCourse.count') do
        post available_courses_path, params: {
          available_course: {
            curriculum_id: curriculums(:one).id, curriculum_course_id: curriculum_courses(:two).id,
            coordinator_id: employees(:chief_john).id, unit_id: units(:omu).id,
            groups_attributes: {
              '0' => {
                name: 'Group 1', quota: 20,
                lecturers_attributes: {
                  '0' => {
                    lecturer_id: employees(:serhat_active).id,
                    coordinator: true
                  }
                }
              }
            }
          }
        }
      end

      available_course = AvailableCourse.last

      assert_equal 'Group 1', available_course.groups.first.name
      assert_equal 20, available_course.groups.first.quota
      assert_equal employees(:serhat_active), available_course.lecturers.first.lecturer
      assert available_course.lecturers.first.coordinator
      assert_redirected_to available_course_path(available_course)
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
          curriculum_id: curriculums(:one).id, curriculum_course_id: curriculum_courses(:two).id,
          groups_attributes: {
            '0' => {
              name: 'Group 1', quota: 10,
              lecturers_attributes: {
                '0' => {
                  lecturer_id: employees(:serhat_active).id,
                  coordinator: true
                }
              }
            }
          }
        }
      }

      available_course.reload

      assert_equal curriculums(:one), available_course.curriculum
      assert_equal curriculum_courses(:two), available_course.curriculum_course
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
