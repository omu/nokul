# frozen_string_literal: true

require 'test_helper'

module OutcomeManagement
  class StandardsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @standard = standards(:one)
    end

    test 'should get index' do
      get standards_path
      assert_response :success
    end

    test 'should get show' do
      get standards_path(@standard)
      assert_response :success
    end

    test 'should get new' do
      get new_standard_path
      assert_response :success
    end

    test 'should create standard' do
      assert_difference('Standard.count') do
        post standards_path, params: {
          standard: {
            accreditation_standard_id: accreditation_standards(:fedek).id,
            status:                    :active,
            unit_ids:                  [units(:fen_bilgisi_ogretmenligi_programi).id]
          }
        }
      end

      standard = Standard.last

      assert_equal accreditation_standards(:fedek), standard.accreditation_standard
      assert_equal units(:fen_bilgisi_ogretmenligi_programi).name, standard.units.map(&:name).join(', ')
      assert standard.active?
      assert_redirected_to standards_path
    end

    test 'should get edit' do
      get edit_standard_path(@standard)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update standard' do
      standard = Standard.last
      patch standard_path(@standard), params: {
        standard: {
          accreditation_standard_id: accreditation_standards(:fedek).id,
          status:                    :passive,
          unit_ids:                  [units(:bilgisayar_muhendisligi_programi).id]
        }
      }

      standard.reload

      assert_equal accreditation_standards(:fedek), standard.accreditation_standard
      assert_equal units(:bilgisayar_muhendisligi_programi).name, standard.units.map(&:name).join(', ')
      assert standard.passive?
      assert_redirected_to standards_path
      assert_equal translate('.update.success'), flash[:info]
    end

    test 'should destroy standard' do
      assert_difference('Standard.count', -1) do
        delete standard_path(@standard)
      end

      assert_redirected_to standards_path
      assert_equal translate('.destroy.success'), flash[:info]
    end

    test 'should get units' do
      get units_standards_path(term: 'Eğitim Fakültesi', format: :json)
      assert_response :success
      assert_equal 'application/json', response.media_type
      assert_equal 1, JSON.parse(response.body).count
    end

    private

    def translate(key)
      t("outcome_management.standards#{key}")
    end
  end
end
