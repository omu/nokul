# frozen_string_literal: true

module Patron
  module RoleBuilder
    mattr_accessor :all, default: {}

    def roles
      @roles ||= {}
    end

    def role(identifier, name:, permissions:)
      role = Role.new(
        name:        name,
        identifier:  identifier,
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
        @permissions = permissions
        check!
      end

      private

      def check!
        permissions.each_key do |permission|
          raise ArgumentError, "Permission not found: #{permission}" unless PermissionBuilder.all.key?(permission)
        end
      end
    end

    private_constant :Role
  end
end
