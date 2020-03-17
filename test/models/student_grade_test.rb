# frozen_string_literal: true

require 'test_helper'

class StudentGradeTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  include ReferenceTestModule

  # relations
  has_many :students, dependent: :nullify
end
