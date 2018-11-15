# frozen_string_literal: true

require 'test_helper'

module Calendar
  class CalendarTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @calendar_type = calendar_types(:lisans_onlisans)
    end

    test 'should get index' do
      get calendar_types_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_calendar_type_link')
    end

    test 'should get show' do
      get calendar_type_path(@calendar_type)
      assert_response :success
    end

    test 'should get new' do
      get new_calendar_type_path
      assert_response :success
    end

    test 'should create calendar type' do
      assert_difference('CalendarType.count') do
        post calendar_types_path, params: {
          calendar_type: {
            name: 'Test Calendar Type'
          }
        }
      end

      calendar_type = CalendarType.last

      assert_equal 'Test Calendar Type', calendar_type.name
      assert_redirected_to calendar_types_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_calendar_type_path(@calendar_type)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update calendar type' do
      calendar_type = CalendarType.last
      patch calendar_type_path(calendar_type),
            params: {
              calendar_type: { name: 'Test Calendar Type Update' }
            }

      calendar_type.reload

      assert_equal 'Test Calendar Type Update', calendar_type.name
      assert_redirected_to calendar_types_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy calendar type' do
      assert_difference('CalendarType.count', -1) do
        delete calendar_type_path(CalendarType.last)
      end

      assert_redirected_to calendar_types_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("calendar.calendar_types#{key}")
    end
  end
end
