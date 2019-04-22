# frozen_string_literal: true

require 'test_helper'

module Patron
  class RoleAssignmentTest < ActiveSupport::TestCase
    extend Support::Minitest::AssociationHelper
    extend Support::Minitest::ValidationHelper
    
    # relations
    belongs_to :role
    belongs_to :user

    # validations: uniqueness
    validates_uniqueness_of :role_id
  end
end
