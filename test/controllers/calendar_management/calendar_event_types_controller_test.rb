# frozen_string_literal: true

require 'test_helper'

module CalendarManagement
  class CalendarEventTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @calendar_event_type = calendar_event_types(:excused_mid_term_applications)
      @form_params = %w[name identifier category]
    end

    test 'should get index' do
      get calendar_management_calendar_event_types_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.index.new_calendar_event_type_link')
    end

    test 'should get new' do
      get new_calendar_management_calendar_event_type_path
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#calendar_event_type_#{param}"
        end
      end
    end

    test 'should create document' do
      assert_difference('CalendarEventType.count') do
        post calendar_management_calendar_event_types_path, params: {
          calendar_event_type: {
            name: 'Sample Event Type',
            category: 'exams',
            identifier: 'sample_event_type_exams'
          }
        }
      end

      assert_equal 'create', @controller.action_name

      calendar_event_type = CalendarEventType.last

      assert_equal 'Sample Event Type', calendar_event_type.name
      assert_equal 'exams', calendar_event_type.category
      assert_equal 'sample_event_type_exams', calendar_event_type.identifier
      assert_redirected_to calendar_management_calendar_event_types_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_calendar_management_calendar_event_type_path(@calendar_event_type)

      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#calendar_event_type_#{param}"
        end
      end
    end

    test 'should update document' do
      calendar_event_type = CalendarEventType.last
      patch calendar_management_calendar_event_type_path(calendar_event_type), params: {
        calendar_event_type: { name: 'Another Event Type' }
      }

      assert_equal 'update', @controller.action_name
      calendar_event_type.reload

      assert_equal 'Another Event Type', calendar_event_type.name
      assert_redirected_to calendar_management_calendar_event_types_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy document' do
      assert_difference('CalendarEventType.count', -1) do
        delete calendar_management_calendar_event_type_path(calendar_event_types(:calendar_event_type_to_delete))
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to calendar_management_calendar_event_types_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("calendar_management.calendar_event_types#{key}")
    end
  end
end
