# frozen_string_literal: true

require 'test_helper'

module OutcomeManagement
  class UnitStandardsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @unit_standard = unit_standards(:one)
    end

    test 'should get index' do
      get unit_standards_path
      assert_response :success
    end

    test 'should get show' do
      get unit_standards_path(@unit_standard)
      assert_response :success
    end

    test 'should get new' do
      get new_unit_standard_path
      assert_response :success
    end

    test 'should create unit standard' do
      assert_difference('UnitStandard.count') do
        post unit_standards_path, params: {
          unit_standard: {
            unit_id: units(:fen_bilgisi_ogretmenligi_programi).id,
            standard_id: standards(:fedek).id,
            status: :active
          }
        }
      end

      unit_standard = UnitStandard.last

      assert_equal units(:fen_bilgisi_ogretmenligi_programi), unit_standard.unit
      assert_equal standards(:fedek), unit_standard.standard
      assert unit_standard.active?
      assert_redirected_to unit_standards_path
    end

    test 'should get edit' do
      get edit_unit_standard_path(@unit_standard)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update unit standard' do
      unit_standard = UnitStandard.last
      patch unit_standard_path(@unit_standard), params: {
        unit_standard: {
          unit_id: units(:fen_bilgisi_ogretmenligi_programi).id,
          standard_id: standards(:fedek).id,
          status: :passive
        }
      }

      unit_standard.reload

      assert_equal units(:fen_bilgisi_ogretmenligi_programi), unit_standard.unit
      assert_equal standards(:fedek), unit_standard.standard
      assert unit_standard.passive?
      assert_redirected_to unit_standards_path
      assert_equal translate('.update.success'), flash[:info]
    end

    test 'should destroy unit standard' do
      assert_difference('UnitStandard.count', -1) do
        delete unit_standard_path(@unit_standard)
      end

      assert_redirected_to unit_standards_path
      assert_equal translate('.destroy.success'), flash[:info]
    end

    private

    def translate(key)
      t("outcome_management.unit_standards#{key}")
    end
  end
end
