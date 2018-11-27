# frozen_string_literal: true

require 'test_helper'

module Calendar
  class AcademicCalendarsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @academic_calendar = academic_calendars(:lisans_calendar_fall_2017_2018)
    end

    test 'should get index' do
      get academic_calendars_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_academic_calendar_link')
    end

    test 'should get show' do
      get academic_calendar_path(@academic_calendar)
      assert_response :success
    end

    test 'should get new' do
      get new_academic_calendar_path
      assert_response :success
    end

    test 'should create academic calendar' do
      assert_difference('AcademicCalendar.count') do
        post academic_calendars_path, params: {
          academic_calendar: {
            name: 'Test Academic Calendar', academic_term_id: academic_terms(:spring_2018_2019).id,
            calendar_type_id: calendar_types(:yuksek_lisans).id, senate_decision_date: '04.07.2018',
            senate_decision_no: 'SK001/4', description: 'Açıklama',
            calendar_events_attributes: {
              0 => {
                calendar_title_id: calendar_titles(:one).id, start_date: '16.01.2019', end_date: '05.02.2019'
              }
            }
          }
        }
      end

      academic_calendar = AcademicCalendar.last

      assert_equal 'Test Academic Calendar', academic_calendar.name
      assert_equal 'SK001/4', academic_calendar.senate_decision_no
      assert_equal 1, academic_calendar.calendar_events.count
      assert_redirected_to academic_calendars_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_academic_calendar_path(@academic_calendar)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update academic calendar' do
      academic_calendar = AcademicCalendar.last
      patch academic_calendar_path(academic_calendar),
            params: {
              academic_calendar: {
                name: 'Test Academic Calendar Test', senate_decision_no: 'SK001/5', description: 'Açıklama Test',
                unit_ids: [units(:fen_bilgisi_ogretmenligi_programi).id]
              }
            }

      academic_calendar.reload

      assert_equal 'Test Academic Calendar Test', academic_calendar.name
      assert_equal 'SK001/5', academic_calendar.senate_decision_no
      assert_equal 'Açıklama Test', academic_calendar.description
      assert_includes academic_calendar.units.ids, units(:fen_bilgisi_ogretmenligi_programi).id
      assert_redirected_to academic_calendar_path(academic_calendar)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy academic calendar' do
      assert_difference('AcademicCalendar.count', -1) do
        delete academic_calendar_path(AcademicCalendar.last)
      end

      assert_redirected_to academic_calendars_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("calendar.academic_calendars#{key}")
    end
  end
end
