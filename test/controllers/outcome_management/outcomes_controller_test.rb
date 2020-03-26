# frozen_string_literal: true

require 'test_helper'

module OutcomeManagement
  class OutcomesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @accreditation_standard = accreditation_standards(:one)
      @outcome = outcomes(:one)
    end

    test 'should get show' do
      get accreditation_standard_outcome_path(@accreditation_standard, @outcome)
      assert_response :success
    end

    test 'should get new' do
      get new_accreditation_standard_outcome_path(@accreditation_standard)
      assert_response :success
    end

    test 'should create outcome' do
      assert_difference('Outcome.count', 2) do
        post accreditation_standard_outcomes_path(@accreditation_standard), params: {
          outcome: {
            code: 'PÇ-3', name: 'Çözme ve uygulayabilme becerisi',
            micro_outcomes_attributes: {
              '0' => { accreditation_standard_id: @accreditation_standard.id, code: 'PÇ3-1', name: 'Çözme becerisi' }
            }
          }
        }
      end

      outcome = @accreditation_standard.macro_outcomes.last

      assert_equal 'PÇ-3', outcome.code
      assert_equal 'Çözme ve uygulayabilme becerisi', outcome.name
      assert_equal 1, outcome.micro_outcomes.count
      assert_redirected_to accreditation_standard_path(@accreditation_standard)
    end

    test 'should get edit' do
      get edit_accreditation_standard_outcome_path(@accreditation_standard, @outcome)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update outcome' do
      patch accreditation_standard_outcome_path(@accreditation_standard, @outcome), params: {
        outcome: {
          code: 'PÇ1', name: 'Seçme ve uygulama becerisi.',
          micro_outcomes_attributes: {
            '0' => { accreditation_standard_id: @accreditation_standard.id, code: 'PÇ1-1', name: 'Seçme becerisi.' }
          }
        }
      }

      @outcome.reload

      assert_equal 'PÇ1', @outcome.code
      assert_equal 'Seçme ve uygulama becerisi.', @outcome.name
      assert_equal 'PÇ1-1', @outcome.micro_outcomes.ordered.first.code
      assert_redirected_to accreditation_standard_path(@accreditation_standard)
      assert_equal translate('.update.success'), flash[:info]
    end

    test 'should destroy outcome' do
      assert_difference('Outcome.count', -1) do
        delete accreditation_standard_outcome_path(@accreditation_standard, @outcome)
      end

      assert_redirected_to accreditation_standard_path(@accreditation_standard)
      assert_equal translate('.destroy.success'), flash[:info]
    end

    private

    def translate(key)
      t("outcome_management.outcomes#{key}")
    end
  end
end
