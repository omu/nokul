# frozen_string_literal: true

require 'test_helper'

class AcademicTermTest < ActiveSupport::TestCase
  setup do
    @academic_term = academic_terms(:fall_2017_2018)
  end

  # relations

  # validations: presence
  %i[
    year
    term
    start_of_term
    end_of_term
  ].each do |property|
    test "presence validations for #{property} of a academic term" do
      @academic_term.send("#{property}=", nil)
      assert_not @academic_term.valid?
      assert_not_empty @academic_term.errors[property]
    end
  end

  # validations: uniqueness
  test 'academic term should be unique based on year' do
    fake_term = @academic_term.dup
    assert_not fake_term.valid?
    assert_not_empty fake_term.errors[:year]
  end

  # enums
  {
    term: { fall: 0, spring: 1, summer: 2 }
  }.each do |property, hash|
    hash.each do |key, value|
      test "have a #{key} value of #{property} enum" do
        enums = AcademicTerm.defined_enums.with_indifferent_access
        assert_equal enums.dig(property, key), value
      end
    end
  end

  # scopes
  test 'active scope returns active academic terms' do
    assert_includes AcademicTerm.active, academic_terms(:fall_2018_2019)
    assert_not_includes AcademicTerm.active, academic_terms(:spring_2017_2018)
  end
end
