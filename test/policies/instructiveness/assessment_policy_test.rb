# frozen_string_literal: true

require 'pundit_test_case'

module Instructiveness
  class AssessmentPolicyTest < PunditTestCase
    %w[
      edit?
      update?
    ].each do |method|
      test method do
        assert_permit     users(:serhat), record: employees(:serhat_active)
        assert_not_permit users(:john),   record: employees(:chief_john)
        assert_not_permit users(:mine)
      end
    end
  end
end
