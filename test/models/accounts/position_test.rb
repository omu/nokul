# frozen_string_literal: true

require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  # relations
  %i[
    duty
    administrative_function
  ].each do |property|
    test "an identity can communicate with #{property}" do
      assert positions(:baum_dean).send(property)
    end
  end
end
