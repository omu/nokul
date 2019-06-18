# frozen_string_literal: true

module Patron
  module PermissionBuilder
    mattr_accessor :all, default: {}

    def permissions
      @permissions ||= {}
    end

    # Example
    # permission :foo, name: 'Foo', description: 'Desc'
    def permission(identifier, name:, description:)
      generated_permission = Permission.new(
        name:        name,
        identifier:  identifier,
        description: description
      )

      permissions[identifier]           = generated_permission
      PermissionBuilder.all[identifier] = generated_permission
    end

    Permission = Struct.new(:name, :identifier, :description, keyword_init: true)

    private_constant :Permission
  end
end
