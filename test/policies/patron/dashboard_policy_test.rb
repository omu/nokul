# frozen_string_literal: true

require 'pundit_test_case'

module Patron
  class DashboardPolicyTest < PunditTestCase
    test 'index?' do
      assert_permit     users(:serhat)
      assert_not_permit users(:mine)
    end
  end
end
