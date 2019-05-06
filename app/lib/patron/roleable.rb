# frozen_string_literal: true

module Patron
  module Roleable
    extend ActiveSupport::Concern

    included do
      has_many :role_assignments, class_name: 'Patron::RoleAssignment', dependent: :destroy
      has_many :roles, class_name: 'Patron::Role', through: :role_assignments
      has_many :permissions, class_name: 'Patron::Permission', through: :roles
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

    alias role? roles?
    alias permission? permissions?
  end
end
