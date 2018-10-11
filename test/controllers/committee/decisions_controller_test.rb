# frozen_string_literal: true

require 'test_helper'

module Committee
  class DecisionsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @committee = units(:muhendislik_fakultesi_yonetim_kurulu)
      @meeting_agenda = meeting_agendas(:one)
      @decision = committee_decisions(:one)
    end

    test 'should get new' do
      get new_committee_meeting_agenda_decision_path(@committee, @meeting_agenda)
      assert_response :success
    end

    test 'should create committee decision' do
      meeting_agenda = meeting_agendas(:four)
      assert_difference('CommitteeDecision.count') do
        post committee_meeting_agenda_decisions_path(@committee, meeting_agenda),
             params: {
               committee_decision: {
                 description: 'Karar test',
                 meeeting_agenda: meeting_agendas(:four)
               }
             }
      end

      decision = CommitteeDecision.last
      assert_equal 'Karar test', decision.description
      assert_equal '2018/4', decision.decision_no
      assert_equal 2018, decision.year
      assert_redirected_to committee_meeting_path(@committee, meeting_agenda.committee_meeting)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_committee_meeting_agenda_decision_path(@committee, @meeting_agenda, @decision)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update committee decision' do
      decision = @committee.decisions.last
      patch committee_meeting_agenda_decision_path(@committee, @meeting_agenda, @decision),
            params: {
              committee_decision: {
                description: 'Karar güncellendi'
              }
            }
      decision.reload

      assert_equal 'Karar güncellendi', decision.description
      assert_redirected_to committee_meeting_path(@committee, @meeting_agenda.committee_meeting)
      assert_equal translate('.update.success'), flash[:notice]
    end

    private

    def translate(key)
      t("committee.decisions#{key}")
    end
  end
end
