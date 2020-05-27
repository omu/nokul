# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class AvailableCourseGroupsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @group = available_course_groups(:elective_course_group)
      @available_course = @group.available_course
    end

    test 'should get new' do
      get new_available_course_available_course_group_path(@available_course)
      assert_response :success
    end

    test 'should create available course group' do
      assert_difference('AvailableCourseGroup.count') do
        post available_course_available_course_groups_path(@available_course), params: create_params
      end

      group = AvailableCourseGroup.last
      assert_equal 'Group 4', group.name
      assert_equal 10, group.quota
      assert_redirected_to available_course_path(@available_course)
      assert_equal translate('.create.success'), flash[:info]
    end

    test 'should not create available course group when event is not active' do
      deactivate_event
      assert_no_difference('AvailableCourseGroup.count') do
        post available_course_available_course_groups_path(@available_course), params: create_params
      end

      assert_redirected_to available_course_path(@available_course)
      assert_equal t('errors.not_proper_event_range', scope: %i[course_management available_courses]), flash[:info]
    end

    test 'should get edit' do
      get edit_available_course_available_course_group_path(@available_course, @group)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update available course group' do
      patch available_course_available_course_group_path(@available_course, @group), params: {
        available_course_group: {
          name: 'Group', quota: 15,
          lecturers_attributes: {
            '0' => {
              lecturer_id: employees(:rector).id,
              coordinator: false
            }
          }
        }
      }

      @group.reload

      assert_equal 'Group', @group.name
      assert_equal 15, @group.quota
      assert_redirected_to available_course_path(@available_course)
      assert_equal translate('.update.success'), flash[:info]
    end

    test 'should destroy available course group' do
      assert_difference('AvailableCourseGroup.count', -1) do
        AvailableCourse.reset_counters(@available_course.id, :groups_count)
        delete available_course_available_course_group_path(@available_course, @group)
      end

      assert_redirected_to available_course_path(@available_course)
      assert_equal translate('.destroy.success'), flash[:info]
    end

    test 'should not destroy available course group when event is not active' do
      deactivate_event
      assert_no_difference('AvailableCourseGroup.count') do
        delete available_course_available_course_group_path(@available_course, @group)
      end

      assert_redirected_to available_course_path(@available_course)
      assert_equal t('errors.not_proper_event_range', scope: %i[course_management available_courses]), flash[:info]
    end

    private

    def deactivate_event
      event = @available_course.unit.calendars.active.last.event('add_drop_available_courses')
      event.update(end_time: Time.zone.now - 1.day)
    end

    def create_params
      {
        available_course_group: {
          name: 'Group 4', quota: 10,
          lecturers_attributes: {
            '0' => { lecturer_id: employees(:serhat_active).id, coordinator: true }
          }
        }
      }
    end

    def translate(key)
      t("course_management.available_course_groups#{key}", course: @available_course.name)
    end
  end
end
