# frozen_string_literal: true

require 'test_helper'

class AcademicTermTest < ActiveSupport::TestCase
  test 'should not save academic term without year' do
    academic_terms(:one).year = nil
    assert_not academic_terms(:one).valid?
  end

  test 'should not save academic term without term' do
    academic_terms(:one).term = nil
    assert_not academic_terms(:one).valid?
  end

  test 'term should be unique based on year' do
    assert_not academic_terms(:one).dup.valid?
  end

  test 'should contain academic calendars' do
    assert academic_terms(:one).academic_calendars
  end
end
