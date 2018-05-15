# frozen_string_literal: true

require 'test_helper'

class AcademicTermTest < ActiveSupport::TestCase
  # validation tests for the presence of listed properties
  %i[
    year
    term
  ].each do |property|
    test "presence validations for #{property} of a academic term" do
      academic_terms(:one).send("#{property}=", nil)
      refute academic_terms(:one).valid?
      assert_not_nil academic_terms(:one).errors[property]
    end
  end
  
  # relational tests
  test 'should contain academic calendars' do
    assert academic_terms(:one).academic_calendars
  end

  # duplication tests
  test 'term should be unique based on year' do
    assert_not academic_terms(:one).dup.valid?
  end

end
