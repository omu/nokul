# frozen_string_literal: true

require 'test_helper'

class AcademicTermTest < ActiveSupport::TestCase
  # validation tests for the presence of listed properties
  %i[
    year
    term
  ].each do |property|
    test "presence validations for #{property} of an academic term" do
      academic_terms(:fall_2017_2018).send("#{property}=", nil)
      refute academic_terms(:fall_2017_2018).valid?
      refute_empty academic_terms(:fall_2017_2018).errors[property]
    end
  end

  # relational tests
  test 'should contain academic calendars' do
    assert academic_terms(:fall_2017_2018).academic_calendars
  end

  # duplication tests
  test 'term should be unique based on year' do
    refute academic_terms(:fall_2017_2018).dup.valid?
  end
end
