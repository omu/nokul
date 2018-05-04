# frozen_string_literal: true

require 'test_helper'

class StudentDisabilityTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = student_disability_types(:autism)
  end
end
