# frozen_string_literal: true

require 'pundit_test_case'

class RegulationPolicyTest < PunditTestCase
  %w[
    index?
    show?
  ].each do |method|
    test method do
      assert_permit     users(:serhat)
      assert_not_permit users(:mine)
    end
  end
end
