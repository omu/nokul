# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTypeTest < ActiveSupport::TestCase
  test 'title_id should be unique based on type_id' do
    title_type = calendar_title_types(:one)
    dup_title_type = title_type.dup
    title_type.status = 1
    refute title_type.valid? && dup_title_type.valid?, 'Title should be unique based on type'
  end
end
