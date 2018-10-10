# frozen_string_literal: true

require 'test_helper'

class ReferencesTest < ActiveSupport::TestCase
  %i[
    administrative_functions
    administrative_units
    cities
    countries
    entrance_types
    gender
    kod_bid
    martyrs_relatives
    nationalities
    staff_titles
    student_disability_types
    student_dropout_types
    student_education_levels
    student_entrance_point_types
    student_entrance_types
    student_grades
    student_grading_systems
    studentship_rights
    studentship_statuses
    unit_instruction_languages
    unit_instruction_types
    unit_statuses
    unit_types
    university_types
  ].each do |method|
    test "trying to get #{method} reference" do
      assert Xokul::Yoksis::References.send method
    end
  end

  test 'trying to get districts reference' do
    assert Xokul::Yoksis::References.districts city_code: 55

    assert_raises Net::HTTPError, Net::HTTPFatalError do
      Xokul::Yoksis::References.districts city_code: -1
      Xokul::Yoksis::References.districts city_code: 'city code as string'
    end
  end
end
