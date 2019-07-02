# frozen_string_literal: true

module LdapSyncTrigger
  extend ActiveSupport::Concern

  class LdapTrigger
    attr_reader :user_finder_method

    def initialize(user_finder_method)
      @user_finder_method = user_finder_method
    end

    def after_commit(record)
      user =  case user_finder_method
              when Proc  then user_finder_method.call(record)
              when :self then record
              else            record.public_send(user_finder_method)
              end

      if record.destroyed? && record.class.name == 'User'
        Ldap::Client.destroy(Ldap::Entity.new(user))
      else
        Ldap::EntitySaveJob.perform_later(user)
      end
    end

    # alias after_save_commit after_commit
    # alias after_destroy_commit after_commit
  end

  class_methods do
    def ldap_sync_trigger(method, attributes: [])
      @ldap_sync_trigger_configuration = {
        method: method, attributes: attributes
      }

      after_save_commit LdapTrigger.new(method), if: -> {
        attributes.blank? || attributes.any? { |key| previous_changes.include?(key) }
      }

      after_destroy_commit LdapTrigger.new(method)
    end

    def ldap_sync_trigger_configuration
      @ldap_sync_trigger_configuration ||= {}
    end
  end
end
