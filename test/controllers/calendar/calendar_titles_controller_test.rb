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
    end

    test 'should get edit' do
      get edit_calendar_title_path(@calendar_title)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update calendar title' do
      calendar_title = calendar_titles(:one)
      patch calendar_title_path(calendar_title),
            params: { calendar_title: { type_ids: [calendar_types(:veteriner).id] } }

      calendar_title.reload

      assert_equal [calendar_types(:veteriner).id], calendar_title.types.ids
      assert_redirected_to calendar_titles_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    private

    def translate(key)
      t("calendar.calendar_titles#{key}")
    end
  end
end
