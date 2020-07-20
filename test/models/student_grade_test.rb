# frozen_string_literal: true

require 'test_helper'

class StudentGradeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  include ReferenceTestModule

  # relations
  has_many :students, foreign_key: :stage_id, inverse_of: :stage, dependent: :nullify
end
