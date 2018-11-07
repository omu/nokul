# frozen_string_literal: true

require 'test_helper'

class AcademicTermTest < ActiveSupport::TestCase
  setup do
    @academic_term = academic_terms(:fall_2017_2018)
  end

  # relations
  test 'a academic term can communicate with academic_calendars' do
    assert @academic_term.send(:academic_calendars)
  end

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
  %i[
    fall
    spring
    summer
  ].each do |property|
    test "academic term can respond to #{property} enum" do
      assert AcademicTerm.send(property)
    end
  end
end
