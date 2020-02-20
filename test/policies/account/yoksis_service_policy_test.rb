# frozen_string_literal: true

require 'pundit_test_case'

module Account
  class YoksisServicePolicyTest < PunditTestCase
    %w[
      fetch?
    ].each do |method|
      test method do
        assert_permit     users(:serhat)
        assert_not_permit users(:mine)
      end
    end
  end
end
