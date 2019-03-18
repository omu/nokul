# frozen_string_literal: true

require 'test_helper'

module CalendarManagement
  class CalendarsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @calendar = calendars(:uzem_calendar)
      @form_params = %w[name description timezone academic_term_id]
    end

    test 'should get index' do
      get calendars_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.index.new_calendar_link')
    end

    test 'should get new' do
      get new_calendar_path
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#calendar_#{param}"
        end
      end
    end

    test 'should create document' do
      assert_difference('Calendar.count') do
        post calendars_path, params: {
          calendar: {
            name: 'Sample Calendar',
            description: 'lorem and ipsum',
            timezone: 'Istanbul',
            academic_term_id: AcademicTerm.first.id,
            committee_decision_ids: [committee_decisions(:one).id]
          }
        }
      end

      assert_equal 'create', @controller.action_name

      calendar = Calendar.last

      assert_equal 'Sample Calendar', calendar.name
      assert_equal 'lorem and ipsum', calendar.description
      assert_equal 'Istanbul', calendar.timezone
      assert_redirected_to :calendars
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_calendar_path(@calendar)

      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#calendar_#{param}"
        end
      end
    end

    test 'should update document' do
      calendar = Calendar.last
      patch calendar_path(calendar), params: {
        calendar: { name: 'Another Calendar' }
      }

      calendar.reload

      assert_equal 'update', @controller.action_name
      assert_equal 'Another Calendar', calendar.name
      assert_redirected_to :calendars
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy document' do
      assert_difference('Calendar.count', -1) do
        delete calendar_path(calendars(:calendar_to_delete))
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to :calendars
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("calendar_management.calendars#{key}")
    end
  end
end
