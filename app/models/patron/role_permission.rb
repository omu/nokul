# frozen_string_literal: true

module Patron
  class RolePermission < ApplicationRecord
    # relations
    belongs_to :role
    belongs_to :permission

    # validations
    validates :permission_id, uniqueness: { scope: :role_id }
    validates :privileges, presence: true

    before_validation do
      privileges.to_a.each do |privilege|
        next if available_privileges.include?(privilege)

        errors.add(:base, "Bu izin için #{privilege} geçerli bir ayrıcalık değil")
      end
    end

    # delegates
    delegate :name, :identifier, :available_privileges, to: :permission

    # enums
    flag :privileges, Patron::PermissionBuilder::PRIVILEGES
  end
end
