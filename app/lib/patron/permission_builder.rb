# frozen_string_literal: true

module Patron
  module PermissionBuilder
    mattr_accessor :all, default: ActiveSupport::HashWithIndifferentAccess.new

    SUPPORTED_PRIVILEGES = {
      read:    0,
      write:   1,
      destroy: 2,
      report:  3
    }.freeze

    def self.supported_privileges
      SUPPORTED_PRIVILEGES.sort_by { |_, v| v }.map(&:first)
    end

    def permissions
      @permissions ||= ActiveSupport::HashWithIndifferentAccess.new
    end

    def privilege?(identifier, privilege)
      return false unless permissions.include?(identifier.to_sym)

      permissions[identifier.to_sym].privileges.include?(privilege)
    end

    # Example
    # permission :foo, name: 'Foo', description: 'Desc'
    def permission(identifier, name:, description:, privileges:)
      generated_permission = Permission.new(
        name:        name,
        identifier:  identifier,
        description: description,
        privileges:  available_privileges_check!(privileges)
      )

      permissions[identifier]           = generated_permission
      PermissionBuilder.all[identifier] = generated_permission
    end

    Permission = Struct.new(:name, :identifier, :description, :privileges, keyword_init: true)

    private_constant :Permission

    private

    def available_privileges_check!(privileges)
      privileges.each do |privilege|
        raise "Unavailable privilege: #{privilege}" unless SUPPORTED_PRIVILEGES.key?(privilege)
      end

      privileges.inquiry
    end
  end
end
