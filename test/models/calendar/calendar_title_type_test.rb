# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTypeTest < ActiveSupport::TestCase
  test 'title_id should be unique based on type_id' do
    refute calendar_title_types(:one).dup.valid?
  end
end
