# frozen_string_literal: true

require 'test_helper'

module OutcomeManagement
  class AccreditationStandardsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @accreditation_standard = accreditation_standards(:one)
    end

    test 'should get index' do
      get accreditation_standards_path
      assert_response :success
    end

    test 'should get show' do
      get accreditation_standards_path(@accreditation_standard)
      assert_response :success
    end

    test 'should get new' do
      get new_accreditation_standard_path
      assert_response :success
    end

    test 'should create accreditation standard' do
      assert_difference('AccreditationStandard.count') do
        post accreditation_standards_path, params: {
          accreditation_standard: {
            accreditation_institution_id: accreditation_institutions(:fedek).id,
            version:                      '2020',
            status:                       :active,
            unit_ids:                     [units(:fen_bilgisi_ogretmenligi_programi).id]
          }
        }
      end

      accreditation_standard = AccreditationStandard.last

      assert_equal accreditation_institutions(:fedek), accreditation_standard.accreditation_institution
      assert_equal units(:fen_bilgisi_ogretmenligi_programi).name, accreditation_standard.units.map(&:name).join(', ')
      assert accreditation_standard.active?
      assert_redirected_to accreditation_standards_path
    end

    test 'should get edit' do
      get edit_accreditation_standard_path(@accreditation_standard)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update accreditation standard' do
      accreditation_standard = AccreditationStandard.last
      patch accreditation_standard_path(@accreditation_standard), params: {
        accreditation_standard: {
          accreditation_institution_id: accreditation_institutions(:fedek).id,
          version:                      '2020',
          status:                       :passive,
          unit_ids:                     [units(:bilgisayar_muhendisligi_programi).id]
        }
      }

      accreditation_standard.reload

      assert_equal accreditation_institutions(:fedek), accreditation_standard.accreditation_institution
      assert_equal units(:bilgisayar_muhendisligi_programi).name, accreditation_standard.units.map(&:name).join(', ')
      assert accreditation_standard.passive?
      assert_redirected_to accreditation_standards_path
      assert_equal translate('.update.success'), flash[:info]
    end

    test 'should destroy accreditation standard' do
      assert_difference('AccreditationStandard.count', -1) do
        delete accreditation_standard_path(@accreditation_standard)
      end

      assert_redirected_to accreditation_standards_path
      assert_equal translate('.destroy.success'), flash[:info]
    end

    test 'should get units' do
      get units_accreditation_standards_path(term: 'Eğitim Fakültesi', format: :json)
      assert_response :success
      assert_equal 'application/json', response.media_type
      assert_equal 1, JSON.parse(response.body).count
    end

    private

    def translate(key)
      t("outcome_management.accreditation_standards#{key}")
    end
  end
end
