# frozen_string_literal: true

require 'test_helper'

class TimezoneHelperTest < ActionView::TestCase
  test 'timezone_list_with_offset method returns timezones with offset values' do
    assert timezone_list_with_offset.include?(['Istanbul (+03:00)', 'Istanbul'])
  end
end
