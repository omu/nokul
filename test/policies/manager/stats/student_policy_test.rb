# frozen_string_literal: true

require 'pundit_test_case'

module Manager
  module Stats
    class StudentPolicyTest < PunditTestCase
      %w[
        cities?
        double_major_and_minor?
        genders?
        genders_and_degrees?
        index?
        non_graduates?
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
