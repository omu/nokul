# frozen_string_literal: true

require 'test_helper'

module Patron
  class RolePermissionTest < ActiveSupport::TestCase
    extend Nokul::Support::Minitest::AssociationHelper
    extend Nokul::Support::Minitest::ValidationHelper

    # relations
    belongs_to :role
    belongs_to :permission

    # validations: uniqueness
    validates_uniqueness_of :permission_id
  end
end
