# frozen_string_literal: true

require 'test_helper'

class UniversityTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = university_types(:foundation)
  end

  # relations
  has_many :units
end
