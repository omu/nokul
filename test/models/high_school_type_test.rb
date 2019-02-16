# frozen_string_literal: true

require 'test_helper'

class HighSchoolTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = high_school_types(:aksam_lisesi)
  end

  # relations
  has_many :prospective_students
end
