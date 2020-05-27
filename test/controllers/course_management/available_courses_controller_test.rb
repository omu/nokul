# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class AvailableCoursesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @available_course = available_courses(:elective_course)
      @unit = @available_course.unit
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
        post available_courses_path, params: create_params
      end

      available_course = AvailableCourse.last

      assert_equal 'Group', available_course.groups.first.name
      assert_equal 10, available_course.groups.first.quota
      assert_equal employees(:rector), available_course.lecturers.first.lecturer
      assert available_course.lecturers.first.coordinator
      assert_redirected_to available_course_path(available_course)
    end

    test 'should not create available course when event is not active' do
      deactivate_event
      assert_no_difference('AvailableCourse.count') do
        post available_courses_path, params: create_params
      end

      assert_redirected_to available_courses_path
      assert_equal translate('.errors.not_proper_event_range'), flash[:info]
    end

    test 'should get edit' do
      get edit_available_course_path(@available_course)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update available course' do
      patch available_course_path(@available_course), params: update_params

      @available_course.reload
      assert_equal employees(:rector), @available_course.coordinator
      assert_equal curriculums(:one), @available_course.curriculum
      assert_equal curriculum_courses(:two), @available_course.curriculum_course
      assert_redirected_to available_course_path(@available_course)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should not update specified fields of available course when event is not active' do
      deactivate_event
      patch available_course_path(@available_course), params: update_params

      @available_course.reload
      assert_equal employees(:rector), @available_course.coordinator
      assert_not_equal curriculums(:one), @available_course.curriculum
      assert_not_equal curriculum_courses(:two), @available_course.curriculum_course
      assert_redirected_to available_course_path(@available_course)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy available course' do
      assert_difference('AvailableCourse.count', -1) do
        delete available_course_path(@available_course)
      end

      assert_redirected_to available_courses_path
      assert_equal translate('.destroy.success'), flash[:info]
    end

    test 'should not destroy available course when event is not active' do
      deactivate_event
      assert_no_difference('AvailableCourse.count') do
        delete available_course_path(@available_course)
      end

      assert_redirected_to available_courses_path
      assert_equal translate('.errors.not_proper_event_range'), flash[:info]
    end

    private

    def deactivate_event
      event = @unit.calendars.active.last.event('add_drop_available_courses')
      event.update(end_time: Time.zone.now - 1.day)
    end

    def create_params
      {
        available_course: {
          curriculum_id: curriculums(:one).id, curriculum_course_id: curriculum_courses(:two).id,
          coordinator_id: employees(:chief_john).id, unit_id: @unit.id,
          groups_attributes: { '0' => group_params }
        }
      }
    end

    def update_params
      {
        available_course: {
          curriculum_id: curriculums(:one).id, curriculum_course_id: curriculum_courses(:two).id,
          coordinator_id: employees(:rector).id,
          groups_attributes: { '0' => group_params }
        }
      }
    end

    def group_params
      {
        name: 'Group', quota: 10,
        lecturers_attributes: { '0' => { lecturer_id: employees(:rector).id, coordinator: true } }
      }
    end

    def translate(key)
      t("course_management.available_courses#{key}", course: @available_course.name)
    end
  end
end
