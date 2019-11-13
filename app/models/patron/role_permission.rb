# frozen_string_literal: true

module Patron
  class RolePermission < ApplicationRecord
    # relations
    belongs_to :role
    belongs_to :permission

    # validations
    validates :permission_id, uniqueness: { scope: :role_id }
    validates :privileges, presence: true

    # delegates
    delegate :name, :identifier, to: :permission

    # enums
    flag :privileges, Patron::PermissionBuilder::PRIVILEGES
  end
end
