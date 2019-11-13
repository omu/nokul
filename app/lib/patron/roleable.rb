# frozen_string_literal: true

module Patron
  module Roleable
    extend ActiveSupport::Concern

    included do
      has_many :role_assignments, class_name: 'Patron::RoleAssignment', dependent: :destroy
      has_many :roles,            class_name: 'Patron::Role',           through: :role_assignments
      has_many :permissions,      class_name: 'Patron::Permission',     through: :roles
      has_many :role_permissions, class_name: 'Patron::RolePermission', through: :roles
    end

    def roles?(*identifiers)
      roles.distinct.where(identifier: identifiers).count == identifiers.count
    end

    def any_roles?(*identifiers)
      roles.exists?(identifier: identifiers)
    end

    def permissions?(*identifiers)
      permissions.distinct.where(identifier: identifiers).count == identifiers.count
    end

    def any_permissions?(*identifiers)
      permissions.exists?(identifier: identifiers)
    end

    def privilege?(permission, *privileges)
      role_permissions.includes(:permission)
                      .where_privileges(*privileges.flatten)
                      .where(permissions: { identifier: permission })
                      .exists?
    end

    alias role? roles?
    alias permission? permissions?
  end
end
