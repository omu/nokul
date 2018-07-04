# frozen_string_literal: true

require 'test_helper'

module Calendar
  class CalendarTitlesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @calendar_title = calendar_titles(:one)
    end

    test 'should get index' do
      get calendar_titles_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_calender_title_link')
    end

    test 'should get new' do
      get new_calendar_title_path
      assert_response :success
    end

    test 'should create calendar title' do
      assert_difference('CalendarTitle.count') do
        post calendar_titles_path, params: {
          calendar_title: { name: 'Test Title' }
        }
      end

      calendar_title = CalendarTitle.last

      assert_equal 'Test Title', calendar_title.name
      assert_redirected_to calendar_titles_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_calendar_title_path(@calendar_title)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update calendar title' do
      calendar_title = CalendarTitle.last
      patch calendar_title_path(calendar_title),
            params: { calendar_title: { name: 'Test Title Update' } }

      calendar_title.reload

      assert_equal 'Test Title Update', calendar_title.name
      assert_redirected_to calendar_titles_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy calendar title' do
      assert_difference('CalendarTitle.count', -1) do
        delete calendar_title_path(CalendarTitle.last)
      end

      assert_redirected_to calendar_titles_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("calendar.calendar_titles#{key}")
    end
  end
end
