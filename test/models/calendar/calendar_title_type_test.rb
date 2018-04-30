# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTypeTest < ActiveSupport::TestCase
  test 'title_id should be unique based on type_id' do
    title_type1 = calendar_title_types(:one)
    title_type1.save
    title_type2 = title_type1.dup
    title_type2.status = 1
    dup_title_type1 = title_type1.dup
    assert_not title_type2.valid? && dup_title_type1.valid?, 'Title be unique based on type'
  end
end
