# frozen_string_literal: true

require 'test_helper'

class MembershipNotificationsHelperTest < ActionView::TestCase
  test 'profile completion rate as serhat user' do
    assert_equal profile_completion_rate(users(:serhat)), 100
  end

  test 'profile completion rate as john user' do
    assert_equal profile_completion_rate(users(:john)), 50
  end
end
