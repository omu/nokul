# frozen_string_literal: true

module LDAP
  module Trigger
    extend ActiveSupport::Concern

    class_methods do
      def ldap_trigger(context, attributes: [])
        @config_for_ldap_trigger = {
          context: context, attributes: attributes
        }

        after_destroy_commit LDAP::Sync.new(context)

        after_save_commit LDAP::Sync.new(context), if: -> {
          attributes.blank? || attributes.any? { |key| previous_changes.include?(key) }
        }
      end

      def config_for_ldap_trigger
        @config_for_ldap_trigger ||= {}
      end
    end
  end
end
