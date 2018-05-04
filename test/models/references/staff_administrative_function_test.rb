# frozen_string_literal: true

require 'test_helper'

class StaffAdministrativeFunctionTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = staff_administrative_functions(:rector)
  end
end
