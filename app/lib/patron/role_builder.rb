# frozen_string_literal: true

module Patron
  module RoleBuilder
    mattr_accessor :all, default: {}

    def roles
      @roles ||= {}
    end

    def role(identifier, name:, permissions:)
      role = Role.new(
        name: name,
        identifier: identifier,
        permissions: permissions
      )
      roles[identifier]           = role
      RoleBuilder.all[identifier] = role
    end

    class Role
      attr_reader :identifier, :name, :permissions

      def initialize(identifier:, name:, permissions:)
        @identifier  = identifier
        @name        = name
        @permissions = Set.new(permissions)
        check!
      end

      private

      def check!
        raise ArgumentError, 'Permissions must not be empty' if permissions.blank?

        permissions.each do |permission|
          raise ArgumentError, "Permission not found: #{permission}" unless PermissionBuilder.all.key?(permission)
        end
      end
    end

    private_constant :Role
  end
end
