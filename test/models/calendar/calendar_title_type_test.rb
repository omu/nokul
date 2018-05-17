# frozen_string_literal: true

require 'test_helper'

class CalendarTitleTypeTest < ActiveSupport::TestCase
  # relational tests
  %i[
    type
    title
  ].each do |property|
    test "a calendar title type can communicate with #{property}" do
      assert calendar_title_types(:one).send(property)
    end
  end

  # duplication tests
  test 'title_id should be unique based on type_id' do
    fake = calendar_title_types(:one).dup
    assert_not fake.valid?
    refute_empty fake.errors[:type]
  end
end
