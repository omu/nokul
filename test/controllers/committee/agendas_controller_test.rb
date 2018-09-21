# frozen_string_literal: true

require 'test_helper'

module Committee
  class AgendasControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @agenda = agendas(:one)
      @committee = units(:muhendislik_fakultesi_yonetim_kurulu)
    end

    test 'should get index' do
      get committee_agendas_path(@committee)
      assert_response :success
      assert_select '#add-button', translate('.index.new_agenda_link')
    end

    test 'should get new' do
      get new_committee_agenda_path(@committee)
      assert_response :success
    end

    test 'should create agenda' do
      assert_difference('Agenda.count') do
        post committee_agendas_path(@committee),
             params: {
               agenda: {
                 description: 'Test Agenda', status: :recent,
                 unit_id: units(:muhendislik_fakultesi_yonetim_kurulu).id,
                 agenda_type_id: agenda_types(:two).id
               }
             }
      end

      agenda = Agenda.last

      assert_equal 'Test Agenda', agenda.description
      assert_equal units(:muhendislik_fakultesi_yonetim_kurulu).id, agenda.unit.id
      assert_equal 'recent', agenda.status
      assert_equal agenda_types(:two).id, agenda.agenda_type_id
      assert_redirected_to committee_agendas_path(@committee)
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_committee_agenda_path(@committee, @agenda)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update agenda' do
      agenda = Agenda.last
      patch committee_agenda_path(@committee, agenda),
            params: {
              agenda: {
                description: 'Test Agenda Update', status: :recent,
                unit_id: units(:muhendislik_fakultesi_yonetim_kurulu).id,
                agenda_type_id: agenda_types(:one).id
              }
            }

      agenda.reload

      assert_equal 'Test Agenda Update', agenda.description
      assert_equal units(:muhendislik_fakultesi_yonetim_kurulu).id, agenda.unit_id
      assert_equal 'recent', agenda.status
      assert_equal agenda_types(:one).id, agenda.agenda_type_id
      assert_redirected_to committee_agendas_path(@committee)
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy agenda type' do
      assert_difference('Agenda.count', -1) do
        delete committee_agenda_path(@committee, Agenda.last)
      end

      assert_redirected_to committee_agendas_path(@committee)
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("committee.agendas#{key}")
    end
  end
end
