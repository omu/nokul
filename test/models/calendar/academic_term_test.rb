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
      assert_not academic_terms(:fall_2017_2018).valid?
    end
  end

  # relational tests
  test 'should contain academic calendars' do
    assert academic_terms(:fall_2017_2018).academic_calendars
  end

  # duplication tests
  test 'term should be unique based on year' do
    fake_term = academic_terms(:fall_2017_2018).dup
    assert_not fake_term.valid?
    refute_empty fake_term.errors[:year]
  end

  # nullify tests
  test 'academic calendar nullifies academic_term_id when academic_term gets deleted' do
    academic_terms(:spring_2017_2018).destroy
    assert_nil academic_calendars(:lisans_calendar_spring_2017_2018).academic_term
  end
end
