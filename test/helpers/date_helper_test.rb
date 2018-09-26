# frozen_string_literal: true

require 'test_helper'

class DateHelperTest < ActionView::TestCase
  test 'selectible_year_range should return ranged years as Array' do
    assert selectible_year_range(1990).is_a?(Array)
  end

  test 'selectible_year_range should return a list of ranged years from 1975 to today' do
    assert_equal selectible_year_range(1975).size, Time.zone.now.year - 1975 + 1
  end

  test 'as_date helper formats dates in "d.m.y" format' do
    assert_equal as_date('Wed, 26 Sep 2018'.to_date), '26.09.2018'
  end

  test 'as_date_and_time helper formats times in "d.y.m h:m" format' do
    assert_equal as_date_and_time('Wed, 26 Sep 2018 13:31:46 +0300'.to_time), '26.09.2018 - 13:31'
  end
end
