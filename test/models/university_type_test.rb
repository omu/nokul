# frozen_string_literal: true

require 'test_helper'

class UniversityTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = university_types(:foundation)
  end

  # relations
  test 'university_type can communicate with units' do
    assert @object.units
  end
end
