# frozen_string_literal: true

require 'test_helper'

class AcademicTermHelperTest < ActionView::TestCase
  test 'years should return ranged years as Array' do
    assert years.is_a?(Array)
  end

  test 'years should return a list of ranged years from 1975 to today' do
    assert_equal years.size, Time.zone.now.year - 1975 + 1
  end

  test 'full_name should return a full name for academic term' do
    assert_equal academic_term_full_name(academic_terms(:fall_2017_2018)), '2017 - 2018 / Güz'
  end
end
