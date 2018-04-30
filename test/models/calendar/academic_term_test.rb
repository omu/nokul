# frozen_string_literal: true

require 'test_helper'

class AcademicTermTest < ActiveSupport::TestCase
  test 'should not save academic term without year and term' do
    academic_term = AcademicTerm.new
    assert_not academic_term.save
  end

  test 'term should be unique based on year' do
    academic_term = academic_terms(:one)
    academic_term.save
    academic_term_dup = academic_term.dup
    assert_not academic_term_dup.valid?
  end
end
