# frozen_string_literal: true

require 'test_helper'

module Committee
  class CommitteeMeetingsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @meeting = committee_meetings(:one)
      @committee = units(:muhendislik_fakultesi_yonetim_kurulu)
    end

    test 'should get index' do
      get committee_meetings_path(@committee)
      assert_response :success
      assert_select '#add-button', translate('.index.new_committee_meeting_link')
    end

    test 'should get show' do
      get committee_meeting_path(@committee, @meeting)
      assert_response :success
    end

    test 'should get new' do
      get new_committee_meeting_path(@committee)
      assert_response :success
    end

    test 'should create committee meeting' do
      assert_difference('@committee.meetings.count') do
        post committee_meetings_path(@committee),
             params: {
               committee_meeting: {
                 meeting_no: 5,
                 meeting_date: Time.zone.today,
                 year: Time.zone.today.year,
                 unit: @committee
               }
             }
      end

      committee_meeting = @committee.meetings.last
      assert_equal 5, committee_meeting.meeting_no
      assert_equal Time.zone.today, committee_meeting.meeting_date
      assert_equal Time.zone.today.year, committee_meeting.year
      assert_redirected_to committee_meetings_path(@committee)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_committee_meeting_path(@committee, @meeting)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update committee meeting' do
      committee_meeting = @committee.meetings.last
      patch committee_meeting_path(@committee, committee_meeting),
            params: {
              committee_meeting: {
                meeting_no: 8,
                meeting_date: Time.zone.today - 5.months,
                year: Time.zone.today.year,
                unit: @committee
              }
            }

      committee_meeting.reload

      assert_equal 8, committee_meeting.meeting_no
      assert_equal Time.zone.today - 5.months, committee_meeting.meeting_date
      assert_equal Time.zone.today.year, committee_meeting.year
      assert_redirected_to committee_meetings_path(@committee)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy committee meeting' do
      assert_difference('@committee.meetings.count', -1) do
        delete committee_meeting_path(@committee, @meeting)
      end

      assert_redirected_to committee_meetings_path(@committee)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("committee.meetings#{key}")
    end
  end
end
