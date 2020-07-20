# frozen_string_literal: true

require 'test_helper'

module Patron
  class PermissionTest < ActiveSupport::TestCase
    extend Nokul::Support::Minitest::AssociationHelper
    extend Nokul::Support::Minitest::ValidationHelper

    # relations
    has_many :role_permissions, dependent: :destroy
    has_many :roles, through: :role_permissions

    # validations: presence
    validates_presence_of :name
    validates_presence_of :identifier

    # validations: uniqueness
    validates_uniqueness_of :name
    validates_uniqueness_of :identifier

    # validations: length
    validates_length_of :name
    validates_length_of :identifier
    validates_length_of :description, maximum: 65_535
  end
end
