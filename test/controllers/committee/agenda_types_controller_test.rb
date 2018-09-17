# frozen_string_literal: true

require 'test_helper'

module Committee
  class AgendaTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @agenda_type = agenda_types(:one)
    end

    test 'should get index' do
      get agenda_types_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_agenda_type_link')
    end

    test 'should get new' do
      get new_agenda_type_path
      assert_response :success
    end

    test 'should create agenda type' do
      assert_difference('AgendaType.count') do
        post agenda_types_path, params: {
          agenda_type: { name: 'Yeni Müfredat Oluşturma' }
        }
      end

      agenda_type = AgendaType.last

      assert_equal 'Yeni Müfredat Oluşturma', agenda_type.name
      assert_redirected_to agenda_types_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_agenda_type_path(@agenda_type)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update agenda type' do
      agenda_type = AgendaType.last
      patch agenda_type_path(agenda_type),
            params: {
              agenda_type: { name: 'Yeni Müfredat' }
            }

      agenda_type.reload

      assert_equal 'Yeni Müfredat', agenda_type.name
      assert_redirected_to agenda_types_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy agenda type' do
      assert_difference('AgendaType.count', -1) do
        delete agenda_type_path(AgendaType.last)
      end

      assert_redirected_to agenda_types_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("committee.agenda_types#{key}")
    end
  end
end
