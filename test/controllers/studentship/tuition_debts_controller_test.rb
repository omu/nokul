# frozen_string_literal: true

require 'test_helper'

module Studentship
  class TuitionDebtsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @student = students(:john)
    end

    test 'should get index' do
      get student_tuition_debts_path(@student)
      assert_response :success
      assert_select 'tr' do
        %i[academic_term amount due_date paid].each do |param|
          assert_select 'th', t("studentship.tuition_debts.index.#{param}")
        end
      end
    end
  end
end
