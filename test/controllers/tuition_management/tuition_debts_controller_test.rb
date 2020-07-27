# frozen_string_literal: true

require 'test_helper'

module TuitionManagement
  class TuitionDebtsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @tuition_debt = tuition_debts(:one)
      @student = students(:john)
      @academic_term = academic_terms(:spring_2018_2019)
    end

    test 'should get index' do
      get tuition_debts_path
      assert_response :success
      assert_select '#add-button', translate('.index.add_bulk_tuition_debt')
      assert_select '#add-button', translate('.index.add_personal_tuition_debt')
      assert_select '#collapseSearchLink', t('search')
    end

    test 'should get new' do
      get new_tuition_debt_path
      assert_response :success
    end

    test 'should create tuition debt' do
      assert_difference('TuitionDebt.count') do
        post tuition_debts_path, params: {
          tuition_debt: {
            student_id:       @student.id,
            academic_term_id: @academic_term.id,
            amount:           24_600,
            type:             :personal,
            due_date:         '2019-03-15 23:00:00'
          }
        }
      end

      assert_equal 'create', @controller.action_name

      tuition_debt = TuitionDebt.last

      assert_equal tuition_debt.student, @student
      assert_equal tuition_debt.academic_term, @academic_term
      assert_equal(24_600, tuition_debt.amount)
      assert_equal tuition_debt.due_date, '2019-03-15 23:00:00'.in_time_zone

      assert_redirected_to :tuition_debts
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_tuition_debt_path(@tuition_debt)
      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update tuition debt' do
      tuition_debt = TuitionDebt.last
      patch tuition_debt_path(tuition_debt), params: {
        tuition_debt: {
          amount: 1500,
          paid:   true
        }
      }

      tuition_debt.reload

      assert_equal(1500, tuition_debt.amount)
      assert tuition_debt.paid
      assert_redirected_to tuition_debts_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should be able to create debt from service' do
      post create_with_service_tuition_debts_path(
        tuition_debts: {
          units_id:         [units(:bilgisayar_muhendisligi_programi).id],
          academic_term_id: @academic_term.id,
          due_date:         '2019-03-15 23:00:00'
        }
      )
      assert_redirected_to tuition_debts_path
    end

    test 'should destroy tuition debt' do
      assert_difference('TuitionDebt.count', -1) do
        delete tuition_debt_path(tuition_debts(:tuition_debt_to_delete))
      end

      assert_redirected_to tuition_debts_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("tuition_management.tuition_debts#{key}")
    end
  end
end
