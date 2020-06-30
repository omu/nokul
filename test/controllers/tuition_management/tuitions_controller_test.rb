# frozen_string_literal: true

require 'test_helper'

module TuitionManagement
  class TuitionsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @tuition = tuitions(:one)
    end

    test 'should get index' do
      get tuitions_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_tuition_link')
      assert_select '#collapseSearchLink', t('search')
    end

    test 'should get new' do
      get new_tuition_path
      assert_response :success
    end

    test 'should create tuition' do
      assert_difference('Tuition.count') do
        post tuitions_path, params: {
          tuition: {
            unit_ids:            [units(:bilgisayar_muhendisligi_programi).id],
            academic_term_id:    academic_terms(:spring_2017_2018).id,
            fee:                 350,
            foreign_student_fee: 2500
          }
        }
      end

      assert_equal 'create', @controller.action_name

      tuition = Tuition.last
      assert_equal units(:bilgisayar_muhendisligi_programi).name, tuition.units.map(&:name).join(', ')
      assert_equal academic_terms(:spring_2017_2018), tuition.academic_term
      assert_equal 350, tuition.fee
      assert_equal 2500, tuition.foreign_student_fee

      assert_redirected_to :tuitions
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_tuition_path(@tuition)
      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update tuition' do
      tuition = Tuition.last
      patch tuition_path(tuition),
            params: {
              tuition: { fee: 800 }
            }

      tuition.reload

      assert_equal 800, tuition.fee
      assert_redirected_to tuitions_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy tuition' do
      assert_difference('Tuition.count', -1) do
        delete tuition_path(tuitions(:tuition_to_delete))
      end

      assert_redirected_to tuitions_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("tuition_management.tuitions#{key}")
    end
  end
end
