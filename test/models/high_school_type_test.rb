# frozen_string_literal: true

require 'test_helper'

class HighSchoolTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ReferenceTestModule

  # relations
  has_many :prospective_students, dependent: :nullify
end
