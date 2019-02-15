# frozen_string_literal: true

require 'test_helper'

class UnitStatusTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_statuses(:passive)
  end

  # relations
  has_many :units
end
