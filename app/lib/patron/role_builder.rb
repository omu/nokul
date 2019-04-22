# frozen_string_literal: true

module Patron
  module RoleBuilder
    def roles
      @roles ||= {}
    end

    def role(identifier, name:, permissions:)
      roles[identifier] = Role.new(
        name: name,
        identifier: identifier,
        permissions: permissions
      )
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
        raise ArgumentError, 'Not empty permissions' if permissions.blank?

        permissions.each do |permission|
          raise ArgumentError, "Not found permission, #{permission}" unless PermissionBuilder.all.key?(permission)
        end
      end
    end

    private_constant :Role
  end
end
