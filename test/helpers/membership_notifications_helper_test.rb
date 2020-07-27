# frozen_string_literal: true

require 'test_helper'

class MembershipNotificationsHelperTest < ActionView::TestCase
  test 'profile completion rate as serhat user' do
    assert_equal(100, profile_completion_rate(users(:serhat)))
  end

  test 'profile completion rate as john user' do
    assert_equal(50, profile_completion_rate(users(:john)))
  end
end
