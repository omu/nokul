# frozen_string_literal: true

require 'test_helper'

module Debt
  class TuitionDebtServiceTest < ActiveSupport::TestCase
    setup do
      @academic_term = academic_terms(:active_term)
      @student = students(:mike)
    end

    test 'must be create tuition debt if exceeded_education_period is true' do
      academic_term = academic_terms(:spring_2018_2019)

      Debt::Tuition::Dispatch.perform([units(:bilgisayar_muhendisligi_programi)].flatten,
                                      academic_term,
                                      Time.zone.now + 2.months)

      tuition_debt = TuitionDebt.last

      assert_equal tuition_debt.student, students(:john)
      assert_equal tuition_debt.academic_term, academic_term
      assert_equal tuition_debt.amount.to_f, 305
      assert_equal tuition_debt.description, 'no_discount'
      assert_equal tuition_debt.type, 'bulk'
      assert_not tuition_debt.paid
    end

    test 'student of evening education and has disability' do
      Debt::Tuition::Dispatch.perform([units(:buro_yonetimi_ve_yonetici_asistanligi_io)].flatten,
                                      @academic_term,
                                      Time.zone.now + 2.months)

      tuition_debt = TuitionDebt.last

      assert_equal tuition_debt.student, @student
      assert_equal tuition_debt.academic_term, @academic_term
      assert_equal tuition_debt.amount.to_f, 325
      assert_equal tuition_debt.description, 'disability'
      assert_equal tuition_debt.type, 'bulk'
      assert_not tuition_debt.paid
    end

    test "student of evening education and hasn't disability and scholarship" do
      @student.user.update(disability_rate: 0)

      Debt::Tuition::Dispatch.perform([units(:buro_yonetimi_ve_yonetici_asistanligi_io)].flatten,
                                      @academic_term,
                                      Time.zone.now + 2.months)

      tuition_debt = TuitionDebt.last
      assert_equal tuition_debt.amount.to_f, 650
      assert_equal tuition_debt.description, 'no_discount'
    end
  end
end
