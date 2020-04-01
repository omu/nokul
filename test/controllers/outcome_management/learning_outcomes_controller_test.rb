# frozen_string_literal: true

require 'test_helper'

module OutcomeManagement
  class LearningOutcomesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @accreditation_standard = accreditation_standards(:one)
      @learning_outcome = learning_outcomes(:one)
    end

    test 'should get show' do
      get accreditation_standard_learning_outcome_path(@accreditation_standard, @learning_outcome)
      assert_response :success
    end

    test 'should get new' do
      get new_accreditation_standard_learning_outcome_path(@accreditation_standard)
      assert_response :success
    end

    test 'should create learning outcome' do
      assert_difference('LearningOutcome.count', 2) do
        post accreditation_standard_learning_outcomes_path(@accreditation_standard), params: {
          learning_outcome: {
            code: 'PÇ-3', name: 'Çözme ve uygulayabilme becerisi',
            micro_outcomes_attributes: {
              '0' => { accreditation_standard_id: @accreditation_standard.id, code: 'PÇ3-1', name: 'Çözme becerisi' }
            }
          }
        }
      end

      learning_outcome = @accreditation_standard.macro_outcomes.last

      assert_equal 'PÇ-3', learning_outcome.code
      assert_equal 'Çözme ve uygulayabilme becerisi', learning_outcome.name
      assert_equal 1, learning_outcome.micro_outcomes.count
      assert_redirected_to accreditation_standard_path(@accreditation_standard)
    end

    test 'should get edit' do
      get edit_accreditation_standard_learning_outcome_path(@accreditation_standard, @learning_outcome)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update learning outcome' do
      patch accreditation_standard_learning_outcome_path(@accreditation_standard, @learning_outcome), params: {
        learning_outcome: {
          code: 'PÇ1', name: 'Seçme ve uygulama becerisi.',
          micro_outcomes_attributes: {
            '0' => { accreditation_standard_id: @accreditation_standard.id, code: 'PÇ1-1', name: 'Seçme becerisi.' }
          }
        }
      }

      @learning_outcome.reload

      assert_equal 'PÇ1', @learning_outcome.code
      assert_equal 'Seçme ve uygulama becerisi.', @learning_outcome.name
      assert_equal 'PÇ1-1', @learning_outcome.micro_outcomes.ordered.first.code
      assert_redirected_to accreditation_standard_path(@accreditation_standard)
      assert_equal translate('.update.success'), flash[:info]
    end

    test 'should destroy learning outcome' do
      assert_difference('LearningOutcome.count', -1) do
        delete accreditation_standard_learning_outcome_path(@accreditation_standard, @learning_outcome)
      end

      assert_redirected_to accreditation_standard_path(@accreditation_standard)
      assert_equal translate('.destroy.success'), flash[:info]
    end

    private

    def translate(key)
      t("outcome_management.learning_outcomes#{key}")
    end
  end
end
