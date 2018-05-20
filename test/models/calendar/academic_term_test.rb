# frozen_string_literal: true

require 'test_helper'

class AcademicTermTest < ActiveSupport::TestCase
  # relations
  test 'should contain academic calendars' do
    assert academic_terms(:fall_2017_2018).academic_calendars
  end

  # validations: presence
  %i[
    year
    term
  ].each do |property|
    test "presence validations for #{property} of an academic term" do
      academic_terms(:fall_2017_2018).send("#{property}=", nil)
      assert_not academic_terms(:fall_2017_2018).valid?
    end
  end

  # validations: uniqueness
  test 'term should be unique based on year' do
    fake_term = academic_terms(:fall_2017_2018).dup
    assert_not fake_term.valid?
    assert_not_empty fake_term.errors[:year]
  end
end
