# frozen_string_literal: true

require 'test_helper'

class ProspectiveStudentValidatorTest < ActiveSupport::TestCase
  setup do
    @prospective_student = prospective_students(:mine)
    @unit = units(:matematik_ve_fen_bilimleri_egitimi_bolumu)
    @academic_term = academic_terms(:summer_2017_2018)
  end

  {
    'unit'          => @unit,
    'academic_term' => @academic_term
  }.each do |property, value|
    test "unchangeable variables validation for #{property}" do
      @prospective_student.send("#{property}=", value)

      assert @prospective_student.registered?
      assert_not @prospective_student.save
      assert_not_empty @prospective_student.errors[:base]
      assert_equal I18n.t('validators.prospective_student.unchangeable_variables'),
                   @prospective_student.errors[:base].first
    end
  end
end
