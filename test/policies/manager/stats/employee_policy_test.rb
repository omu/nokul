# frozen_string_literal: true

require 'pundit_test_case'

module Manager
  module Stats
    class EmployeePolicyTest < PunditTestCase
      %w[
        academic?
        index?
      ].each do |method|
        test method do
          assert_permit     users(:serhat)
          assert_permit     users(:rector)
          assert_permit     users(:vice_rector)
          assert_not_permit users(:mine)
        end
      end
    end
  end
end
